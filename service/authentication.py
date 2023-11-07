import pyrebase

firebaseConfig ={
    "apiKey": "AIzaSyCLDNH9DXoiaUfzN3VyjyeDLGYdxHy7cuo",
    "authDomain": "harvest-id.firebaseapp.com",
    "databaseURL": "https://harvest-id.firebaseio.com",
    "projectId": "harvest-id",
    "storageBucket": "harvest-id.appspot.com",
    "messagingSenderId": "160688752737",
    "appId": "1:160688752737:web:5ddbbd9c08260af734c220"
}

firebase = pyrebase.initialize_app(firebaseConfig)
auth = firebase.auth()

def siginup():
    email = user
    password = password_register.value
    password_compair = password_register_confirm.value
    if password == password_compair:
        try:
            sigin = auth.create_user_with_email_and_password(email, password)
            return True
        except:
            return {print("As senhas são diferentes")}