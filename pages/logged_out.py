from flet import *
import back
from utils.base import BasePageLoggedOut as BPLO
from utils.base import convert_h
from utils.base import convert_w
from pages import login
from pages.login import *

class LoggedOutScreen(UserControl):
    def __init__(self,pg):
        super().__init__()
        self.pg = pg
    
    def switch_page(self):
        self.pg.go("/login")
        back.back_ = "/"
    
    def switch_page_register(self):
        self.pg.go('/register')
        back.back_ = '/'

    def build(self):
        return Column(
            controls=[
                BPLO(
                  content= Column(
                      horizontal_alignment= "center",
                      controls= [
                          Container(
                              height= 150
                          ),
                          Container(
                                Image(
                                src = "Harvest-ID_app/assets/images/harvest.png"
                            ),
                            height = 250,
                            width = 250,
                          ),
                          Container(
                              height = 10
                          ),
                          Container(
                              on_click= lambda e: self.switch_page(),
                              height = 50,
                              width = 200,
                              bgcolor = "#FFFFFF",
                              alignment= alignment.center,
                              content = Text("Acessar sua conta",
                                              size=16, 
                                              color= "black",
                                              text_align= "center",
                                              font_family= "SF Pro Semibold"
                                              ),
                              border_radius= 10
                          ),
                          Container(
                              height=10
                          ),
                          Container(
                              on_click= lambda e: self.switch_page_register() ,
                              height = 50,
                              width = 200,
                              bgcolor = "#FFFFFF",
                              alignment= alignment.center,
                              content = Text("Cadastrar Conta",
                                              size=16, 
                                              color= "black",
                                              text_align= "center",
                                              font_family= "SF Pro Semibold"
                                              ),
                              border_radius= 10
                          )                 
                          
                          
                      ]
                  )
                )
            ]
        )
