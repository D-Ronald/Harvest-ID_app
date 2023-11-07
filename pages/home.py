from flet import *
import back
from utils.base import BasePageApp as BPA

class HomeScreen(UserControl):
    def __init__(self, pg):
        super().__init__()

    def switch_page(self,pg):
        super().__init__()
        self.pg = pg
        self.pg.go('/home')
        back.back_ = '/home'

    def build(self):
        return Column(
            controls=[
                Column(

                )
            ]
        )


        