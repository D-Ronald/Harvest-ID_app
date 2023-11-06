from flet import *
from pages.login import LoginScreen
from pages.logged_out import LoggedOutScreen
from pages.home import HomeScreen
from pages.register import RegisterScreen


def views_handler(page):
    return{
        "/" : View(
            route = "/",
            controls = [
                LoggedOutScreen(page)
            ]
        ),

        "/login": View(
            route = "/login",
            controls = [
                LoginScreen(page)
            ]
        ),

        "/home" : View(
            route = "/home",
            controls = [
                HomeScreen(page)
            ]
        ),

        "/register" : View(
            route = "/register",
            controls = [
                RegisterScreen(page)
            ]
        )


    }