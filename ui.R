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
# library(shinydashboard)
library(shinythemes)
library(rintrojs)

############ load the environment variables ##############
source("R/preCreateEnv.R")

############ call the ui function itself #################
shinyUI(
  tagList( #needed for shinyjs
    useShinyjs(),  # Include shinyjs
    introjsUI(),   # Required to enable introjs scripts
    navbarPage(
      id = "intabset", #needed for landing page
      # "Biological Study with Pure Metal Implantation",
      title = div(tags$a(img(src="UK_public_health.png", height=40), 
                         href= "https://cph.uky.edu/"), # title 
                  style = "position: relative; top: -5px;"), # Navigation bar
      windowTitle = "Metals Embedded Study", #t itle for browser tab
      theme = shinytheme("paper"), #Theme of the app (paper navbar)
      collapsible = TRUE, #tab panels collapse into menu in small screens
      header = tags$head(includeCSS("www/styles.css"), # CSS styles
                         HTML("<html lang='en'>"),
                         tags$link(rel="shortcut icon", href="favicon_UK.ico"), #Icon for browser tab
                         #Including Google analytics
                         #includeScript("google-analytics.js"),
                         HTML("<base target='_blank'>"),
                         # cookie_box
      ),
      ###
      tabPanel(
        title = "Home", icon = icon("home"),
        wellPanel(width = 11, style = "margin-left:4%; margin-right:4%;",
                  fluidRow(
                    column(
                      8,
                      h3("Welcome to the Curated Dataset of Biological Study in Rodent Shrapnel Model with Pure Metals Implantation",
                         style="color:#0033A0; font-weight: bold; margin-top:0px;")
                    ), # column
                    column(
                      4, 
                      actionButton("btn_landing",label="Help: Take tour of the tool",
                                   icon=icon('question-circle'),class="down") # actionButton
                    ) #column
                  ), # fluidRow
                  h5("A shiny-based web interface for you to search and download the scientific data."),
        ),# wellPanel    
        fluidRow( 
          width = 12,
          hr(style="margin-top:0px;"), 
          style="margin-left:4%; margin-right:4%;",
          column(
            12, 
            h4("Currently Avaiable Data", style="font-weight: bold;text-align: center"),
            fluidRow(
              column(4, class="landing-page-column",
                     br(), #spacing
                     lp_main_box(image_name= "expression_profiling", 
                                 button_name = 'jump_to_expression', title_box = "Expression Profiling",
                                 description = 'Expression of micro-RNA, mRNA generating via NGS/microarray.'), 
                     br()
              ), # column
              column(4, class="landing-page-column",
                     br(), #spacing
                     lp_main_box(image_name= "concentration", 
                                 button_name = 'jump_to_concentration', title_box = "Metal Concentration",
                                 description = 'Metal concentration at euthanasia dectected by ICP-MS spectrum.'), 
                     br()
              ),
              column(4, class="landing-page-column", 
                     br(), #spacing
                     lp_main_box(image_name= "rat", 
                                 button_name = 'jump_to_weight', title_box = "Body Weight",
                                 description = 'Body weight of the rats at different time points.'),
                     br()
              ),
              hr(),
            )# fluidRow
          )# column
        ), # fluidRow
        fluidRow(
          width = 12,
          hr(), 
          style="margin-left:4%; margin-right:4%;",
          column(
            width = 12, 
            # style="margin-left:4%; margin-right:4%", 
            # hr(),
            fluidRow(
              column(width = 10, offset = 1,
                     div(
                       h4("Military Related Metal Fragments Embedded"), 
                       p("Injuries with embedded metal fragments are the unfortunate consequence of modern armed conflicts, 
                         and many defense personnel survive with the embedded fragments in their bodies. 
                         In response to concerns about embedded metal fragments, the Armed Forces Radiobiology Research Institute 
                         in Bethesda, MD has utilized a rodent model, integrating biokinetics, toxicology and bioinformatics approaches, 
                         to comprehensively investigate the health effects of eight types of military-relevant pure metals implantation on rats.", 
                       ), # p
                       p("As a part of a greater collaboration project, here we present a complemental manuscript which comprehensively describes the curated dataset, 
                         provides any technical details and highlights the validation procedures, to help other reuse the data. 
                         In addition, we developed a searchable database with web interface where researchers could search and download data directly.", 
                       ) # p
                     )# div
              )# column
            )# fluidRow
          )# column
        ), # fluidRow
      ),# tabPanel Home
      
      tabPanel(
        "Expression", value = "expression",
        h3("Data Related to Expression Profiling", style="color:#0033A0;font-weight: bold"),
        br(),
        wellPanel(
          column(
            width = 4,
            h4("Query Options", style="color:white;font-weight: bold"),
            # selectDataVarUI("condt"),
            query_exprs_ui("condt"), 
            style="color:white;background-color:#005ba0;padding:2%;border-radius:8px;"
          ), # column
          column(
            width = 7, style="margin-left:4%; margin-right:4%",
            div(
              # # title="Select an indicator to see comparative information. Click in this box, hit backspace and start to type if you want to quickly find an indicator.",
              h4("Expression Data from Urine, Serum and Muscle Tissue", style="font-weight: bold"),
              p("The data includes:"),
              tags$ul(
                tags$li("Expression values"), 
                tags$li("Information on animal ID, testing sample name and treatment information such as implanted metal name, tissue type, sample collecting time")
                ),# tags$ul
              p("Currently, only micro-RNA sequencing data from samples of urine and serum, and muscle transcription profiling via both NGS and microarray, are available."),
              hr(),
              h4("Export the Query Results to .csv File", style="font-weight: bold"),
              downloadUI("sample", download_item="sample"),
              downloadUI("exprs", download_item="exprs"),
              style="color:black;background-color:white;padding:15px;border-radius:10px"
            ) #div
          ) # column
        ), # wellPanel
        mainPanel(width = 11, style="margin-left:4%; margin-right:4%",
                  fluidRow(
                    column(11,
                           # title = "Preview of the Query Results", 
                           br(), 
                           hr(),
                           h4("Preview of the Query Results", style="color:#0033A0"),
                           div(
                             br(), 
                             strong("Sample Information Under Given Conditions"),
                             playtableExprsUI("sample"),
                             hr(),
                             strong("Expression Value Under Given Conditions"),
                             playtableExprsUI("exprs")
                           ) # div
                    )# column
                  )# fluiRow
        )# mainPanel
      ), # tabPanel Expression
      
      
      tabPanel(
        "Concentration", value = "concentration",
        h3("Data Related to Metal Concentration at Euthanasia", style="color:#0033A0;font-weight: bold"),
        br(), 
        wellPanel(
          column(
            width = 4, 
            h4("Query Options", style="color:white;font-weight: bold"), 
            datasetConUI("data", dataset_label="concentration types", dataset_choices=vec_type_choices), 
            style="color:white;background-color:#005ba0;padding:2%;border-radius:8px;"
          ), # column
          column(
            width = 7, style="margin-left:4%; margin-right:4%", 
            div(
              # title="Select an indicator to see comparative information. Click in this box, hit backspace and start to type if you want to quickly find an indicator.",
              h4("Metal Concentrations Determined By ICP-MS", style="font-weight: bold"), 
              p("The data is generated from three types of tissues: serum, stomach, urine, which includes:"),
              tags$ul(
                tags$li("Concentration of a metal (say Ni) in a tissue in rats embodied with this metal"),
                tags$li("Concentration of a metal (say Ni) in a tissue in rats embodied with Ta"),
                tags$li("Concentration of creatinine at euthanasia which helps to normalize the metal concentration")
              ),# tags$ul
              hr(), 
              h4("Export the Query Results to .csv File", style="font-weight: bold"),
              downloadUI("download_concentration", "concentration"),
              style="color:black;background-color:white;padding:15px;border-radius:10px"
            ) #div
          ), # column
        ), # wellPanel
        mainPanel(width = 11, style="margin-left:4%; margin-right:4%",
                  fluidRow(
                    column(11,
                           # title = "Preview of the Query Results", 
                           br(), 
                           hr(),
                           h4("Preview of the Query Results", style="color:#0033A0"),
                           div(
                             playtableUI("concentration_play")
                           ) # div
                    )# column
                  )# fluiRow
        )# mainPanel
      ), # tabPanel Concentration
      tabPanel(
        "Body Weight", value = "weight", 
        h3("Data Related to Body Weight at Different Time Points", style="color:#0033A0;font-weight: bold"),
        br(),
        wellPanel(
          column(
            width = 4,
            h4("Query Options", style="color:white;font-weight: bold"),
            selectMetalMonthUI("weight", df_data=df_joint_weight), 
            selectListControlUI("animal_id_weight", df_data=df_joint_weight, label="animal id", col="animal_ID"),
            selectListControlUI("weeks_post_implantation", df_data=df_joint_weight, label="weighting time", col="weeks_post_implantation"),
            style="color:white;background-color:#005ba0;padding:2%;border-radius:8px;"
          ), # column
          column(
            width = 7, style="margin-left:4%; margin-right:4%",
            div(
              # title="Select an indicator to see comparative information. Click in this box, hit backspace and start to type if you want to quickly find an indicator.",
              h4("Introduction to the Body Weight Data", style="font-weight: bold"),
              p("The data includes:"),
              tags$ul(
                tags$li("Weight values"), 
                tags$li("Information on animal ID and treatment information such as embodied metal name, euthanized time, weighting time")
              ),# tags$ul
              p("You can search the weight of the rats, by given conditions of metal embedded, the euthanized period, and the weighting time points."),
              hr(),
              h4("Export the Query Results to .csv File", style="font-weight: bold"),
              downloadUI("download_weight", "weight"),
              style="color:black;background-color:white;padding:15px;border-radius:10px"
            ) #div
          ), # column
        ), # wellPanel
        mainPanel(width = 11, style="margin-left:4%; margin-right:4%",
                  fluidRow(
                    column(11,
                           # title = "Preview of the Query Results",
                           br(),
                           hr(),
                           h4("Preview of the Query Results", style="color:#0033A0"),
                           div(
                             playtableUI("weight_play")
                           ) # div
                    )# column
                  )# fluiRow
        )# mainPanel
      )# tabPanel weight
    ), # navbarPage
    
    
    div(style = "margin-bottom: 30px;"), # this adds breathing space between content and footer
    #Copyright warning
    tags$footer(column(6, "© 2022 University of Kentucky"), 
                # column(3, tags$a(href="mailto:douglas.zhang@uky.edu", tags$b("Contact us!"), 
                #                  class="externallink", style = "color: white; text-decoration: none")), 
                # column(3, tags$a(href="https://www.scotpho.org.uk/about-us/scotpho-website-policies-and-statements/privacy-and-cookies", 
                #                  tags$b("Privacy & cookies"), 
                #                  class="externallink", style = "color: white; text-decoration: none")), 
                column(6, actionLink("github", 
                                     label = "Github", 
                                     icon = icon("github"),
                                     style= "color:white;",
                                     onclick = sprintf("window.open('%s')","https://github.com/MuscleOne/")
                ) # actionLink
                ), # column
                style = "position:fixed;
                  text-align:center;
                  left: 0;
                  bottom:0;
                  width:100%;
                  z-index:1000;
                  /*height:28px; /* Height of the footer */
                  color: white;
                  padding: 10px;
                  font-weight: bold;
                  background-color: #0033A0"
    ) #tags$footer
  )# tagList
)

