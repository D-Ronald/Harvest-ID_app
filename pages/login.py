from turtle import back
from flet import *
import back
from utils.base import BasePageLogin as BPL
from service import authentication as au

permiss = False

user = TextField(
            border=InputBorder.NONE,
            color='#262626',
            height=55,
            width=280,
            hint_text='Email',
            hint_style=TextStyle(
                color='#33000000',
                font_family='SF Pro Regular'
            )
        )

password = TextField(
                password= False,
                border=InputBorder.NONE,
                color='#262626',
                height=55,
                width=280,
                hint_text='Senha',
                hint_style=TextStyle(
                    color='#33000000',
                    font_family='SF Pro Regular',
                )
            )
if (user != ""):
    alert_resend_password = AlertDialog(
        title=('Recuperação enviada')
    )

    
def login():
    email = user.value
    passw = password.value 
    try:
        login = au.auth.sign_in_with_email_and_password(email, passw)
        permiss = True
        return permiss
    except:
        return {print(email,passw), print("tente novamente")}

def reset_password():
    email = user.value
    try:
        au.auth.send_password_reset_email(email)
    except:
        print("tente novamente")

 
class LoginScreen(UserControl):
    def switch_page_logof(self):
        self.pg.go("/")
        back.back_ = "/"

    def switch_page_register(self):
        self.pg.go('/register')
        back.back_ = '/login'

    def switch_page_home(self):
        self.pg.go('/home')
        back.back_ = '/'

    def valid(self):
        test = login()
        if test == True:
            self.switch_page_home()
            user.value = ""
            password.value = ""

            
    def __init__(self,pg):
        super().__init__()
        self.pg = pg 
        self.login_button = Container(
                on_click=  lambda e: self.valid(),
                height=44,
                width= 200,
                border_radius=5,
                bgcolor='#192E2F',
                alignment=alignment.center,
                content= Text('Entrar',
                color='white',
                font_family='SF Pro SemiBold',
                size=14,
                text_align='center'
                ),
              )

    def build(self):
        return Column(
        controls=[
            BPL(
            content=Column(
                spacing=0,
                horizontal_alignment='center',
                controls=[
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
                    ])
                ),
                Container(
                    height=70
                ),
                Image(
                    src='assets/images/NameGray.png',
                    width=250
                ),
                Container(
                    height=10
                ),
                Container(
                    Text(
                        "ENTRAR",
                        size=24,
                        color="#3E444F",
                        font_family="SF Pro SemiBold"
                    )
                ),
                Container(
                    height=100
                ),
                Container(
                    alignment=alignment.center,
                    bgcolor="#D9D9D9",
                    height=60,
                    width=343,
                    border_radius=15,
                    content= user
                ),
                Container(
                    height=35
                ),
                Container(
                    alignment=alignment.center,
                    bgcolor="#D9D9D9",
                    height=60,
                    width=343,
                    border_radius=15,
                    content= password
                ),
                Container(
                    height=18
                ),
                Row(
                    width=345,
                    alignment='end',
                    controls=[
                    Container(
                        on_click=lambda _: reset_password(),
                        content=Text("Esqueceu a senha?",
                        color='#192E2F',
                        font_family='SF Pro Medium',
                        size=12,
                        weight='w600',
                ),
                    )
                    ]
                ),
                Container(
                    height=30
                ),
                
                self.login_button,
                Container(
                    height=30,
                ),
                Row(
                    alignment='center',
                    controls=[
                    Container(
                        on_click=lambda _: self.pg.go('/login'),
                        content=Text('Entrar com o Google',
                        color='#192E2F',
                        font_family='SF Pro SemiBold',
                        size=14,
                        text_align='center'
                        ),),
                    ]
                    ),

                Container(height=30),
                Container(  
                    content = Row(
                    alignment='center',
                    controls=[
                    Container(height=0.1,width=375,bgcolor='#000000'),
                    ]
                ),
                ),
                Container(height=18),
                Row(
                    spacing=0,
                    alignment='center',
                    controls=[
                        Text("Não possui conta?",
                        color='#000000',
                        font_family='SF Pro SemiBold',
                        size=14,
                        text_align='center',
                        opacity=0.4
                        ),Container(
                            width=6
                            ),
                        Container(
                        on_click = lambda _: self.switch_page_register(),
                        content=Text("Registre-se.",
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
        
