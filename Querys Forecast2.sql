  SELECT 
 s.[forecast_snapshoot],
 COALESCE(p.period,p1.period) as periodo,
 COALESCE(f.forecast_value, a.actual_value) as valor
 FROM  [dbo].[forecast_actual] r
 left  join actual a
 on a.id_actual = r.fk_id_actual
 left  join forecast f
 on f.id_forecast = r.fk_id_forecast
 left join [dbo].[forecast_snapshoot] s
 on s.[id_forecast_snapshoot] = r.[fk_id_forecast_snapshoot]
 left join period p 
 on p.id_period = f.fk_periodo_id
 left join period p1 
 on p1.id_period = a.fk_id_period