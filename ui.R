## ui.R
############# load the packages ###########################
# requiredPackages = c('shiny','vroom','shinyjs', "shinydashboard")
# for(p in requiredPackages){
#   if(!require(p,character.only = TRUE)) install.packages(p)
#   library(p,character.only = TRUE)
# }
library(shiny)
library(vroom)
library(shinyjs)
# library(devtools)
# install.packages("devtools")
# detach("package:reactable", unload = T)
# devtools::install_github("glin/reactable")
library(reactable)
library(shinydashboard)

############ load the environment variables ##############
source("R/preCreateEnv.R")

############ call the ui function itself #################
shinyUI(
  dashboardPage(
    dashboardHeader(
      title = "Biological Studies with Metal Implants",
      titleWidth = 400
    ),
    ## Sidebar content
    dashboardSidebar(
      sidebarMenu( # menuItem
        menuItem("Home", tabName = "home", icon = icon("th")),
        menuItem("Get Started", tabName = "usages", icon = icon("th")),
        menuItem("Query", tabName = "dashboard", icon = icon("th"),
                 menuSubItem("Expression", tabName = "subitem1"),
                 menuSubItem("Weight", tabName = "subitem2"),
                 menuSubItem("Concentration", tabName = "subitem3") ),
        menuItem("Analysis", tabName = "analysis", icon = icon("th")),
        menuItem("About", tabName = "about", icon = icon("th"))
        # menuItem("Test", tabName = "test", icon = icon("th"))
      )
    ),
    ## Body content
    dashboardBody( # with corresponding tabItem
      
      ##################### frontend of dynamic UI: Query ######################
      tabItems(
        # First tab content
        tabItem(tabName = "subitem1",
                titlePanel("Data Related to Expression Profiling"),
                sidebarLayout(
                  sidebarPanel(h3("Query Conditions"),
                               selectDataVarUI("condt")),# sidebarPanel
                  mainPanel(
                    fluidRow(
                      column(12,
                             box(
                               title = "Export to .csv file", width = NULL, solidHeader = TRUE, status = "primary",
                               # actionButton("submit", label = "Query", width='180px'),
                               # actionButton("restart", label = "Restart", width='180px'),
                               downloadUI("sample", download_item="sample"),
                               downloadUI("exprs", download_item="exprs")
                             ), #box
                             box(
                               title = "Smaple Information and Expression Value", width = NULL, solidHeader = T, status = "primary",
                               h4("Sample Information Under Given Conditions"),
                               playtableUI("sample"),
                               h4("Expression Value Under Given Conditions"),
                               playtableUI("exprs")) #box
                      ),# column
                    ) # fluiRow
                  ) # mainPenel
                ) # sidebarLayout
        ), # tabItem "subitem1"
        # Second tab content
        tabItem(tabName = "subitem2",
                titlePanel("Data Related to Weight at Different Time Points"),
                sidebarLayout(
                  sidebarPanel(
                    h3("Query Conditions"),
                    selectMetalMonthUI("weight", df_data=df_joint_weight), 
                    selectListControlUI("animal_id_weight", df_data=df_joint_weight, label="animal id", col="animal_ID"),
                    selectListControlUI("weeks_post_implantation", df_data=df_joint_weight, label="weighting time", col="weeks_post_implantation")
                  ),# sidebarPanel
                  mainPanel(
                    fluidRow(
                      column(12,
                             box(
                               title = "Export to .csv file", width = NULL, solidHeader = TRUE, status = "primary",
                               downloadUI("download_weight", "weight")
                             ), # box
                             box(
                               title = "Weight Information", width = NULL, solidHeader = T, status = "primary",
                               playtableUI("weight_play")
                             ) #box
                      )#column
                    )# fluiRow
                  )# mainPanel
                )#sidebarLayout
        ),# tabItem "subitem2"
        tabItem(tabName = "subitem3",
                titlePanel("Data Related to Metal Concentration at Euthanasia"),
                sidebarLayout(
                  sidebarPanel(
                    h3("Query Conditions"),
                    datasetConUI("data", dataset_label="concentration types", dataset_choices=vec_type_choices)
                  ),# sidebarPanel
                  mainPanel(
                    fluidRow(
                      column(12,
                             box(
                               title = "Export to .csv file", width = NULL, solidHeader = TRUE, status = "primary",
                               downloadUI("download_concentration", "concentration")
                             ), # box
                             box(
                               title = "concentration Information", width = NULL, solidHeader = T, status = "primary",
                               playtableUI("concentration_play")
                             ) #box
                      )#column
                    )# fluiRow
                  )# mainPanel
                )#sidebarLayout
        ),# tabItem "subitem3"
        
        ############### frontend of static html pages ###########################
        tabItem(tabName = "home", includeHTML("html/home.html")),# tabItem "home"
        tabItem(tabName = "analysis", includeHTML("html/analysis.html")),# tabItem "analysis"
        tabItem(tabName = "usages", includeHTML("html/usages.html")),# tabItem "usages"
        tabItem(tabName = "about", includeHTML("html/about.html")) # tabItem "About"
        # tabItem(tabName = "test", includeHTML("html/test.html")) # tabItem "About"
      ) 
    )# dashboardBody
  )# dashboardPage
)

