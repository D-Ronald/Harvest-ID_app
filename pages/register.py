from turtle import back
from flet import *
from utils.base import BasePageRegister as BPR


class RegisterScreen(UserControl):

    def switch_page_login(self, pg):
        super().__init__()
        self.pg = pg
        self.pg.go('/login')
        back.back_ = '/'
    
    def build(self):
        return Column(
            controls=[
                BPR(
                    content = Column(
                        horizontal_alignment="center",
                        controls= [
                            Container(
                                height= 10
                            ),
                            Container(
                                Image(
                                    src= "Harvest-ID_app/assets/images/NameGray.png"
                                ),
                                width= 250,
                            ),
                            Container(
                                Text(
                                    "CADASTRO",
                                    size= 24,
                                    color= "#3E444F",
                                    font_family= "SF Pro Semibold"
                                )
                            ),
                            
                        ]
                    )
                )
            ]
        )