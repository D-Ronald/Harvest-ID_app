from flet import *
import back
from utils.base import BasePageApp as  BPA
from pages import login


class HomeScreen(UserControl):

    def switch_page(self,pg):
        super().__init__()
        self.pg = pg
        self.pg.go('/home')
        back.back_ = '/home'

    def switch_page_logof(self):
        self.pg.go("/")
        back.back_ = "/"

    def valid():
        login.permiss = False
        self.switch_page_logof()

    def __init__(self,pg):
        super().__init__()
        self.pg = pg 
        self.logout_button = Container(
                on_click=  lambda e: self.valid(),
                height=44,
                width= 200,
                border_radius=5,
                bgcolor='red',
                alignment=alignment.center,
                content= Text('LogOut',
                color='white',
                font_family='SF Pro SemiBold',
                size=14,
                text_align='center'
                ),
              )


    def build(self):
        return Column(
            controls=[
                BPA(
                  content= Column(
                      horizontal_alignment= "center",
                      controls= [
                          Container(
                              height= 100
                          ),
                          Container(
                              content=Text("Bem vinde!",color='#192E2F',size=24),
                              height=100,
                              
                            ),
                            Container(
                                height= 100
                            ),
                          Container(
                                content = Text("Logout", 
                                               text_align="center",
                                               color="#FFFFFF",
                                               size=16,
                                               font_family="SF Pro SemiBold"),
                                height=50,
                                width=200,
                                bgcolor="red",
                                border_radius= 15,
                                on_click= lambda e: self.switch_page_logof(),
                                alignment= alignment.center
                            )  
                          
                      ]
                  )
                )
            ]
        )
