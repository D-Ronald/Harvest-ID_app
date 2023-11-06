# import pyrebase
# from pages.login import LoginScreen

# email = LoginScreen.user.content.value
# password = LoginScreen.user.content.value

# firebaseConfig = {
#   "apiKey": "AIzaSyCLDNH9DXoiaUfzN3VyjyeDLGYdxHy7cuo",
#   "authDomain": "harvest-id.firebaseapp.com",
#   "projectId": "harvest-id",
#   "storageBucket": "harvest-id.appspot.com",
#   "messagingSenderId": "160688752737",
#   "appId": "1:160688752737:web:5ddbbd9c08260af734c220"
# }

# firebase = pyrebase.initialize_app(firebaseConfig)
# auth = firebase.auth()

# def logon_task():
#     try:
#         auth.sign_in_with_email_and_password(email, password)
#         print("Successfully logged in")
#         LoginScreen.switch_page_home
#     except:
#         print("Invalid email or password")
#     return