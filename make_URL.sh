urlescape () {
  sed -f <(urlescape_sed)
}
urlescape_sed () {
  echo 's/%/%25/g'
  echo 's/ /%20/g'
  echo 's/#/%23/g'
  echo 's/?/%3f/g'
}

bookmarklet () {
  cat <<END
<head>
    <title>Quick QR Code</title>
    <style>
     #main{
         display:grid;
         height:100%;
     }
     #qrcode{
         align-self:center;
         justify-self:center;
     }
     #url{
         margin-top:auto;
     }
    </style>
</head>
<div id=main>
    <svg id='qrcode' xmlns='http://www.w3.org/2000/svg'>
    </svg>
    <input id='url' type='text' placeholder='http://example.org'>
</div>
<script type='text/javascript'>
$(bookmarklet_js_script | closure-compiler)
</script>
END
}
bookmarklet_js_script () {
  cat qrcodejs/qrcode.js
  cat <<END
var qrcode=new QRCode(document.getElementById('qrcode'),{useSVG:true});
var elUrl=document.getElementById('url');
elUrl.onchange=function(){
    qrcode.makeCode(elUrl.value)
};
END
}

echo data:text/html,$(bookmarklet | minify --type html | urlescape) > URL
