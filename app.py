import flet as ft
from flet import * 
from pages import  views
from  pages.views import views_handler

def main(page: ft.page):

    def route_change(route):
        page.views.clear()
        page.views.append(
            views_handler(page)[page.route]
        )

    page.fonts = {
        "SF Pro Bold": "fonts/SFProText-Bold.ttf",
        "SF Pro Heavy": "fonts/SFProText-Heavy.ttf",
        "SF Pro HeavyItalic": "fonts/SFProText-HeavyItalic.ttf",
        "SF Pro Light": "fonts/SFProText-Light.ttf",
        "SF Pro Medium": "fonts/SFProText-Medium.ttf",
        "SF Pro Regular": "Harvest-ID_app/assets/fonts/SFProText-Regular.ttf",
        "SF Pro Semibold": "Harvest-ID_app/assets/fonts/SFProText-Semibold.ttf",
        "SF Pro SemiboldItalic": "fonts/SFProText-SemiboldItalic.ttf",
    }
    
    page.on_route_change = route_change
    page.go("/")

ft.app(target=main, assets_dir="assets")

