<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="theme-color" content="#080808">
<title>J.A.R.V.I.S.</title>
<style>
*{box-sizing:border-box}
body{
 margin:0;background:#080808;color:#f5c542;
 font-family:Arial,sans-serif;text-align:center;
 min-height:100vh;padding:24px 16px;
}
h1{letter-spacing:7px;margin-top:25px}
.sub{color:#aaa;letter-spacing:3px;font-size:12px}
.ring{
 width:210px;height:210px;border:3px solid #d5a52c;
 border-radius:50%;margin:35px auto;
 display:grid;place-items:center;
 box-shadow:0 0 25px #b8862644,inset 0 0 25px #b8862644;
 animation:pulse 3s infinite;
}
.core{
 width:135px;height:135px;border:2px solid #a92323;
 border-radius:50%;display:grid;place-items:center;
 color:#fff;font-size:25px;background:#160909;
}
@keyframes pulse{50%{box-shadow:0 0 40px #d5a52c88}}
.panel{
 max-width:520px;margin:20px auto;padding:18px;
 border:1px solid #72591e;border-radius:12px;
 background:#111;
}
button{
 background:#a51d1d;color:white;border:1px solid #d5a52c;
 padding:13px 18px;border-radius:8px;margin:5px;
 font-weight:bold;
}
input{
 width:100%;padding:14px;background:#080808;
 border:1px solid #72591e;color:white;border-radius:8px;
}
#reply{color:#eee;min-height:45px;line-height:1.5}
.small{font-size:12px;color:#999}
</style>
</head>
<body>
<h1>J.A.R.V.I.S.</h1>
<div class="sub">JUST A RATHER VERY INTELLIGENT SYSTEM</div>
<div class="ring"><div class="core">J.A.R.V.I.S.</div></div>

<div class="panel">
 <p>SYSTEM STATUS: <span id="status">ONLINE</span></p>
 <p id="reply">Good day. J.A.R.V.I.S. systems are ready.</p>
 <input id="message" placeholder="Speak or type a message...">
 <button onclick="sendMessage()">SEND</button>
 <button onclick="listen()">VOICE INPUT</button>
 <button onclick="speakReply()">SPEAK</button>
</div>

<p class="small">J.A.R.V.I.S. • Personal Assistant Prototype</p>

<script>
let lastReply="Good day. How may I assist you?";

function respond(message){
 const m=message.toLowerCase();
 if(m.includes("hello")||m.includes("hi"))
  return "Good day. How can I help you?";
 if(m.includes("your name"))
  return "I am J.A.R.V.I.S., your personal assistant.";
 if(m.includes("time"))
  return "The current time is "+new Date().toLocaleTimeString("en-GB")+".";
 if(m.includes("date"))
  return "Today is "+new Date().toLocaleDateString("en-GB")+".";
 if(m.includes("how are you"))
  return "All systems are operational. Thank you for asking.";
 if(m.includes("thank"))
  return "You are most welcome.";
 return "I understand your message. My conversational AI connection has not yet been configured.";
}

function sendMessage(){
 const input=document.getElementById("message");
 const message=input.value.trim();
 if(!message)return;
 lastReply=respond(message);
 document.getElementById("reply").textContent=lastReply;
 input.value="";
}

function speakReply(){
 if(!("speechSynthesis" in window)){
  alert("Speech is not supported in this browser.");return;
 }
 speechSynthesis.cancel();
 const speech=new SpeechSynthesisUtterance(lastReply);
 speech.lang="en-GB";
 speech.rate=0.92;
 speech.pitch=0.85;
 const voices=speechSynthesis.getVoices();
 const british=voices.find(v=>v.lang==="en-GB");
 if(british)speech.voice=british;
 speechSynthesis.speak(speech);
}

function listen(){
 const Recognition=window.SpeechRecognition||window.webkitSpeechRecognition;
 if(!Recognition){
  alert("Voice input is not supported in this browser.");return;
 }
 const recognition=new Recognition();
 recognition.lang="en-GB";
 recognition.onresult=e=>{
  document.getElementById("message").value=e.results[0][0].transcript;
  sendMessage();
 };
 recognition.onerror=()=>document.getElementById("status").textContent="VOICE UNAVAILABLE";
 recognition.start();
}
</script>
</body>
</html>
