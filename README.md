# Ktao

## Based in Get Pattern: 
This app is based in [getx_pattern](https://github.com/kauemurakami/getx_pattern)

    - /app  
    # Estructure in modules
    # This is where all the application's directories will be contained  
    - /data
    # Directory responsible for containing everything related to our data
        - /service
            # This is where we store our Services
            - my_service.dart
        - /provider
        # Our data provider, can be an api, local database or firebase for example.
            - my_api_provider.dart
        # Here, our asynchronous data request, http, local database functions must remain ...
        - /model
        # Our classes, or data models responsible for abstracting our objects.
            - my_model.dart
        - /repository
            - my_repository.dart
        # Here our repositories are just classes that will mediate the communication between our controller and our data.
        # Our controllers won't need to know where the data comes from, and you can use more than one repository on a controller if you need to.
        # The repositories must be separated by entities, and can almost always be based on their database tables.
        # And inside it will contain all its functions that will request data from a local api or database.
        # That is, if we have a user table that we will persist as, edit, add, update and delete, all these functions are requested 
        # from an api, we will have a repository with this object of the api where we will call all the respective 
        # functions to the user. So the controller does not need to know where it comes from, the repository being a 
        # mandatory attribute for the controllers in this model, you should always initialize the controller with at 
        # least one repository, see the example repos.
    - /modules
    # Each module consists of a page, its respective GetXController and its dependencies or Bindings.
    # We treat each screen as an independent module, as it has its only controller, and can also contain its dependencies.
    # If you use reusable widgets in this, and only in this module, you can choose to add a folder for them.
        - /my_module
            - my_page.dart
            - my_controller.dart or my_service.dart, or both.
            - my_binding.dart
            - /local_widgets
    # The Binding class is a class that decouples dependency injection, while "binding" routes to the state manager and the dependency manager.
    # This lets you know which screen is being displayed when a specific controller is used and knows where and how to dispose of it.
    # In addition, the Binding class allows you to have SmartManager configuration control.
    # You can configure how dependencies are to be organized and remove a route from the stack, or when the widget used for disposition, or none of them.

    - /global_widgets 
    # Widgets that can be reused by multiple **modules**.  

    - /routes
    # In this repository we will deposit our routes and pages.  
    # We chose to separate into two files, and two classes, one being routes.dart, containing its constant routes and the other for routing.  
        - my_routes.dart
        # class Routes {
        # This file will contain your constants ex:  
        # class Routes { const HOME = '/ home'; }  
        - my_pages.dart
        # This file will contain your array routing ex :  
        # class AppPages { static final pages = [  
        #  GetPage(name: Routes.HOME, page:()=> HomePage()) 
        # ]};  

    - /theme
    #Here we can create themes for our widgets, texts and colors
        - text_theme.dart  
        # inside ex: final textTitle = TextStyle(fontSize: 30)  
        - color_theme.dart  
        # inside ex: final colorCard = Color(0xffEDEDEE)  
        - app_theme.dart  
        # inside ex: final textTheme = TextTheme(headline1: TextStyle(color: colorCard))  
     - /utils
    #Here you can insert utilities for your application, such as masks, form keys or widgets
        - keys.dart  
        # inside ex: static final GlobalKey formKey = GlobalKey<FormState>();
        - masks.dart  
        # inside ex: static final maskCPF = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});  
        - helpers.dart  
    # Use classes to make your variables easier to use, eg Keys.myKey, Masks.maskCPF

- main.dart  
# main file
# proposed by william Silva and Kauê Murakami
