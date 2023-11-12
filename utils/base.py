from flet import *

height = 712
width = 375

def convert_h(h):
    return (h/height)*100

def convert_w(w):
    return (w/width)*100

class BasePageLoggedOut(UserControl):
  def __init__(self, content=None):
    super().__init__()
    self.content = content
  def build(self):
    return Column(
      controls=[
        Container(
          height= height,
          width= width,
          bgcolor= "#192E2F",
          content=self.content
        )
      ]
    )
  
class BasePageLogin(UserControl):
  def __init__(self, content=None):
    super().__init__()
    self.content = content
  def build(self):
    return Column(
      controls=[
        Container(
          height= height,
          width= width,
          bgcolor= "#FFFFFF",
          content=self.content
        )
      ]
    )
  
class BasePageApp(UserControl):
  def __init__(self, content=None):
    super().__init__()
    self.content = content
  def build(self):
    return Column(
      controls=[
        Container(
          height= height,
          width= width,
          bgcolor= "#FFFFFF",
          content=self.content
        )
      ]
    )

class BasePageRegister(UserControl):
  def __init__(self, content=None):
    super().__init__()
    self.content = content
  def build(self):
    return Column(
      controls=[
        Container(
          height= height,
          width= width,
          bgcolor= "#FFFFFF",
          content=self.content
        )
      ]
    )

