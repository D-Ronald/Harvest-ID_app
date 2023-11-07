from turtle import back
from flet import *
from utils.base import BasePageRegister as BPR
import back
from service import authentication as au


user_register = TextField(
            border=InputBorder.NONE,
            color='#262626',
            height=60,
            width=250,
            hint_text='Email',
            hint_style=TextStyle(
                color='#33000000',
                font_family='SF Pro Regular'
            )
        )

password_register = TextField(
                password= True,
                border=InputBorder.NONE,
                color='#262626',
                height=60,
                width=250,
                hint_text='Senha',
                hint_style=TextStyle(
                    color='#33000000',
                    font_family='SF Pro Regular',
                )
            )

password_register_confirm = TextField(
                password= True,
                border=InputBorder.NONE,
                color='#262626',
                height=60,
                width=250,
                hint_text='Senha',
                hint_style=TextStyle(
                    color='#33000000',
                    font_family='SF Pro Regular',
                )
            )

def siginup():
    email = user_register.value
    password = password_register.value
    password_compair = password_register_confirm.value
    if password == password_compair and len(password)>=6:
        try:
            sigin = au.auth.create_user_with_email_and_password(email, password_compair)
            return True
        except:
            return {print("algo falhou"),print(email+password_compair+password)}
    else: 
        return {print("As senhas são diferentes ou não possuem 6 digitos")}



class RegisterScreen(UserControl):

    def switch_page_logof(self):
        self.pg.go("/")
        back.back_ = "/"

    def switch_page_login(self):
        self.pg.go("/login")
        back.back_ = "/"

    def valid(self):
        test = siginup()
        if test == True:
            self.switch_page_login()

    def __init__(self,pg):
        super().__init__()
        self.pg = pg 
        self.siginup_button = Container(
                on_click=  lambda e: self.valid(),
                height=44,
                width= 200,
                border_radius=5,
                bgcolor='#192E2F',
                alignment=alignment.center,
                content= Text('Cadastrar',
                color='white',
                font_family='SF Pro SemiBold',
                size=14,
                text_align='center'
                ),
              )
    
    def build(self):
        return Column(
            controls=[
                BPR(
                    content = Column(
                        horizontal_alignment="center",
                        controls= [
                            Container(padding=padding.only(left=18,top=25),
                    content=Row(
                        alignment="end",
                        controls=[
                            Container(
                                width=60,
                                height=30,
                                on_click=lambda _: self.switch_page_logof(),
                                content=Image(
                                    src='assets/images/back.png'
                                )
                                )
                        ]
                    ) 
                            ),
                            Container(
                                height= 50
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
                            Container(
                                height= 15
                            ),
                            Container(
                                alignment=alignment.center,
                                bgcolor="#D9D9D9",
                                height=60,
                                width=343,
                                border_radius=15,
                                content= user_register
                            ),
                            Container(
                                height= 15
                            ),
                            Container(
                                alignment=alignment.center,
                                bgcolor="#D9D9D9",
                                height=60,
                                width=343,
                                border_radius=15,
                                content= password_register
                            ),
                            Container(
                                height= 15
                            ),
                            Container(
                                alignment=alignment.center,
                                bgcolor="#D9D9D9",
                                height=60,
                                width=343,
                                border_radius=15,
                                content= password_register_confirm
                            ),
                            Container(
                                height= 30
                            ),
                            self.siginup_button,
                            Container(
                                height= 30
                            ),
                            Container(  
                                content = Row(
                                alignment='center',
                                controls=[
                                Container(height=0.1,width=375,bgcolor='#000000')
                                ]
                                )
                            ),
                            Container(
                                height= 10
                            ),
                             Row(
                                spacing=0,
                                alignment='center',
                                controls=[
                                    Text("já possui conta?",
                                    color='#000000',
                                    font_family='SF Pro SemiBold',
                                    size=14,
                                    text_align='center',
                                    opacity=0.4
                                    ),Container(
                                        width=6
                                        ),
                                    Container(
                                    on_click = lambda _: self.switch_page_login(),
                                    content=Text("Entre aqui.",
                                    color='#192E2F',
                                    font_family='SF Pro Regular',
                                    size=14,
                                    text_align='center',
                                    ),
                                    )
                                ]
                            )
                            
                            
                        ]
                    )
                )
            ]
        )