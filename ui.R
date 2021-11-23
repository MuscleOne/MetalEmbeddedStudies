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
                    selectInput("metal_2", "Metal Implanted", choices = (unique(df_sample_info_pheno[,"metal_embodied"])), multiple = TRUE),
                    selectInput("month_2", "Euthanized Month Post-implanted", choices = sort(unique(df_sample_info_pheno[, "euthanized_period"])), multiple = TRUE),
                    selectInput("animal_id_2", "Animal id", choices = sort(unique(df_sample_info_pheno[, "animal_ID"])), multiple = TRUE),
                    selectInput("time_point", "Weighting Time", choices = sort(unique(df_joint_weight[, "time_point"])), multiple = TRUE)
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
                               playtableUI("weight")
                               # verbatimTextOutput("weight")
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
                    selectInput("metal_3", "metal embodied", choices = unique(df_sample_info_pheno[, "metal_embodied"]), multiple = TRUE),
                    selectInput("month_3", "euthanized time", choices = sort(unique(df_sample_info_pheno[, "euthanized_period"])), multiple = TRUE),
                    selectInput("animal_id_3", "animal id", choices = sort(unique(df_sample_info_pheno[, "animal_ID"])), multiple = TRUE),
                    selectInput("measure_type", "measure type", choices = sort(unique(df_joint_concentration[, "measure_type"])), multiple = TRUE)
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
                               playtableUI("concentration")
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

