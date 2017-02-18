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
# animint2gist(plot.list = viz,
#              description = "Carbon Dioxide Uptake in Grass Plants",
#              browse = TRUE,
#              out.dir = "assign1_CO2")


# Data needed here

plot_data <- function(){
  # Plot the bar graph with option to select country
  p1 <- ggplot() +
    # Plot bar graph to show growth of each country
    geom_bar(data = country_data,
             aes(x = Name, y = pop_growth, fill = Code,
                 clickSelects = Code, showSelected = Year),
             colour = "black",
             stat = "identity", position = "identity") +
    theme(legend.position = "none") +
    ggtitle("Comparing Population Growth (%)") +
    xlab("Country") +
    ylab("Population Growth (%)") +
    # Tilt text in X axis
    theme(axis.text.x  = element_text(angle=75)) +
    theme_animint(width=600, height= 600)
  
  p2 <- ggplot() +
    # Tall rect to select year
    make_tallrect(country_data, "Year", alpha = 0.50, colour = "grey35") +
    # Plot points showing yearly growth
    geom_point(data = country_data,
               aes(x=Year, y=pop_growth, colour = Code,
                   clickSelects = Year, showSelected = Code),
               size = 4) +
    # Plot line between points
    geom_line(data = country_data,
              aes(x=Year, y=pop_growth, colour = Code,
                  showSelected = Code)) +
    theme_animint(width=600, height= 600) +
    # theme_classic() +
    ggtitle("Population Growth (%) over Time") +
    xlab("Year") +
    ylab("Population Growth (%)")
  
  plots <- list(plot1 = p1,
                plot2 = p2)
  plots$selector.types <- list(Code = "single")
  plots$time <- list(variable = "Year", ms = 5000)
  plots$duration <- list(Year = 500, Code = 1000)
  return(plots)
}

viz.pop <- plot_data()
animint::animint2dir(viz.pop, "./test_delieoe")
# animint2gist(plot.list = viz.pop,
#              description = "Population Growth Data",
#              browse = TRUE,
#              out.dir = "assign1_pop")

# Animation link: 
# http://bl.ocks.org/faizan-khan-iit/raw/3ef22797749d6af0fb50917612f16a96/
