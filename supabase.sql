-- Traky · base de datos
-- Pégalo completo en Supabase → SQL Editor → New query → Run. Se puede ejecutar más de una vez.

-- 1. Una fila por persona con todo su Traky (hábitos, marcas diarias, tareas, categorías).
create table if not exists public.traky_data (
  user_id    uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  rev        bigint not null default 0,          -- marca de tiempo del último cambio (para sincronizar)
  updated_at timestamptz not null default now()
);

-- 2. Seguridad: cada persona solo ve y modifica su propia fila.
alter table public.traky_data enable row level security;

drop policy if exists "traky: leer lo propio"     on public.traky_data;
drop policy if exists "traky: crear lo propio"    on public.traky_data;
drop policy if exists "traky: editar lo propio"   on public.traky_data;
drop policy if exists "traky: borrar lo propio"   on public.traky_data;

create policy "traky: leer lo propio"   on public.traky_data for select to authenticated using ((select auth.uid()) = user_id);
create policy "traky: crear lo propio"  on public.traky_data for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "traky: editar lo propio" on public.traky_data for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "traky: borrar lo propio" on public.traky_data for delete to authenticated using ((select auth.uid()) = user_id);

revoke all on public.traky_data from anon;
grant select, insert, update, delete on public.traky_data to authenticated;

-- 3. Fecha de actualización automática.
create or replace function public.traky_touch() returns trigger
language plpgsql set search_path = '' as $$
begin new.updated_at := now(); return new; end; $$;

drop trigger if exists traky_touch on public.traky_data;
create trigger traky_touch before update on public.traky_data
  for each row execute function public.traky_touch();

-- 4. Progreso mes a mes por persona (para que tú lo consultes en Supabase).
--    % = hábitos marcados / hábitos registrados ese mes. La app calcula además los días programados.
create or replace view public.traky_progreso_mensual
with (security_invoker = true) as
select
  t.user_id,
  u.email,
  left(l.dia, 7)                                         as mes,
  count(*) filter (where jsonb_array_length(l.marcas) > 0) as dias_con_marcas,
  sum(jsonb_array_length(l.marcas))                      as marcas
from public.traky_data t
join auth.users u on u.id = t.user_id
cross join lateral jsonb_each(coalesce(t.data->'log', '{}'::jsonb)) as l(dia, marcas)
group by t.user_id, u.email, left(l.dia, 7);

revoke all on public.traky_progreso_mensual from anon, authenticated;
