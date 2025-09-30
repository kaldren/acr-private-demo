import streamlit as st
import requests

st.title("Container Demo UI")
st.text("This text will change if the backend is called successfully.")

API_URL = "http://app-backend-dev"

def call_hi_get():
    try:
        response = requests.get(f"{API_URL}/hi")
        if response.status_code == 200:
            st.text(response.json().get("message", "No message in response"))
    except requests.RequestException as e:
        st.text(f"Error reaching backend: {e}")
    
if st.button("Call /hi endpoint!"):
    response = call_hi_get()

