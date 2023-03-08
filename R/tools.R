corr_delay <- function(x, y, tmax = 10) {
  n = length(x)
  
  foreach(i = 0:tmax, icount()) %do% {
    ind_x = seq(1, n-i)
    ind_y = seq(i, n)

    cor.test(x[ind_x], y[ind_y]) %$% 
      data.table(t = i, r = statistic, pvalue = p.value)
  } %>% do.call(rbind, .)
}
