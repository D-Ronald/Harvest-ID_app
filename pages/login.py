from flet import *
import back
from utils.base import BasePageLogin as BPL
from service import auth

user = Container(
            alignment= alignment.center,
            padding=padding.only(
            left=20,
            right=20,
            bottom=6),
            bgcolor="#D9D9D9",
            height=60,
            width=300,
            border=border.all(color='#1A000000',width=0.5,),
            border_radius=15,
            content=TextField(
                border=InputBorder.NONE,
                color='#3E444F',
                height=40,
                width=300,
                hint_text='Usuário',
                hint_style=TextStyle(
                    color='#3E444F',
                    font_family='SF Pro Regular', 
            ),
            )
        )

class LoginScreen(UserControl):
    def switch_page_home(self):
        self.pg.go('/home')
        back.back_ = '/'
    
    def switch_page_register(self):
        self.pg.go('/register')
        back.back_ = '/login'

    
    def __init__(self,pg):
        super().__init__()
        self.pg = pg 

    password = Container(
            alignment=alignment.center,
            padding=padding.only(
                left=20,
                right=20,
                bottom=6),
            bgcolor="#D9D9D9",
            height=60,
            width=300,
            border=border.all(color='#1A000000', width=0.5, ),
            border_radius=15,
            content=TextField(
                border=InputBorder.NONE,
                color='#3E444F',
                height=40,
                width=300,
                hint_text='Senha',
                hint_style=TextStyle(
                    color='#3E444F',
                    font_family='SF Pro Regular',
                ),

            )
        )   
    def login():
        print(user.data)
        
    login_button = Container(
            on_click= login,
            height= 40,
            width= 150,
            border_radius = 10,
            # bgcolor='#3797EF',
            bgcolor='#192E2F',
            alignment=alignment.center,
            content= Text('Entrar',
            color='white',
            font_family='SF Pro SemiBold',
            size=16,
            text_align='center'
            ),
            )
    
    

    def build(self):
        return Column(
            controls=[
                BPL(
                    content = Column(
                        horizontal_alignment= "center",
                        controls = [
                            Container(
                                height = 50
                            
                            ),
                            Container(
                                Image(
                                    src = "Harvest-ID_app/assets/images/NameGray.png"
                                ),
                                width = 250,
                                
                            ),
                            Container(
                                height = 5
                            ),
                            Container(
                                Text(
                                    "LOGIN",
                                    size= 24,
                                    color= "#3E444F",
                                    font_family= "SF Pro Semibold"
                                )
                            ),
                            Container(height= 25),
                            user,
                            Container(height= 10),
                            self.password,
                            Container(height= 10),
                            self.login_button,
                            Container(height= 10),
                            Container(
                                alignment=alignment.center,
                                padding=padding.only(
                                    left=20,
                                    right=20,
                                    bottom=6),
                                bgcolor="#D9D9D9",
                                height=40,
                                width=300,
                                border_radius=15,
                                content = Text("Entrar com sua conta Google", 
                                    color="#3E444F"
                                    ),
                                ),
                                Container(
                                alignment=alignment.center,
                                padding=padding.only(
                                    left=20,
                                    right=20,
                                    bottom=6),
                                bgcolor="#D9D9D9",
                                height=40,
                                width=300,
                                border_radius=15,
                                content = Text("Entrar com o facebook", 
                                    color="#3E444F"
                                    ),
                                ),
                                Container(
                                    height= 10
                                ),
                                Container(
                                    Text(
                                        "Esqueceu sua senha?",
                                        size= 14,
                                        color= "#3797EF",
                                        font_family= "SF Pro Regular"
                                    )
                                ),
                                Container(
                                    height= 10
                                ),
                                Container(
                                    Text(
                                        "Não possui conta?",
                                        size= 14,
                                        color= "#3E444F",
                                        font_family= "SF Pro Regular"
                                    )
                                ),
                                Container(
                                    Text(
                                        "Registre-se já!",
                                        size= 14,
                                        color= "#3797EF",
                                         ),
                                    on_click= lambda e: self.switch_page_register(),
                                )
                                
                        ]
                        )
                )
            ]
        )