library(animint)
data("CO2")

# The CO2 uptake of six plants from Quebec and six plants from Mississippi
# was measured at several levels of ambient CO2 concentration.
# Half the plants of each type were chilled overnight before
# the experiment was conducted.
# 
# 
# Concentration (x-axis): Ambient CO2 concentrations (mL/L)
# Uptake (y-axis) : CO2 uptake rates (umol/m^2 sec)
# Plant (legend): a unique identifier for each plant. Total 12
# Type (facet): The origin of the plant - Mississippi or Quebec
# Treatment (facet): Whether the treatment provided was Chilled/Non-chilled

plot1 <- ggplot() + 
  geom_point(aes(x=conc, y=uptake,
                 color=Plant),
             data = CO2) + 
  geom_path(aes(x=conc, y=uptake,
                color=Plant),
            data = CO2) +
  facet_grid(Type ~ Treatment, labeller = label_both) +
  theme_animint(width=1000, height=600)

plot1 <- plot1 + labs(x = "Concentration",
                      y = "Uptake",
                      colour = "Plant")
plot1 <- plot1 + ggtitle("Carbon Dioxide Uptake in Grass Plants")

viz <- list(p=plot1)
viz$selector.types <- list(Plant="multiple")
animint2dir(viz, "./test_chick")
