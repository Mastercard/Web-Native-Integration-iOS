const click2payInstance = new Click2Pay()

function sendMessageToNative(platform, json, methodName){
  console.log("sending value to native...")
  var formattedJSON = JSON.stringify(json, 0, 2);
  switch(platform) {
    case "ios":
       window.webkit.messageHandlers.jsMessageHandler.postMessage(formattedJSON);
       break;
    case "android":
      JSBridge.showMessageInNative(json, methodName);
      break;
  }
}

function initSdk(platform, reqString) {
  console.log('inside init:')
  console.log("init req: "+ reqString);

  let request = JSON.parse(reqString);
  let promise = new Promise(
    function(resolve, reject) {
      click2payInstance.init(request).then(resolve)
    }
  );
  promise.then(
    value => {
      sendMessageToNative(platform, value, "init");
    },
    error => {
      sendMessageToNative(platform, error, "init");
      console.log('Init API rejected '+ error)
    }
  );
}

function getCards(platform) {
  console.log('inside getCards:')
  let promise = new Promise(
    function(resolve, reject) {
      click2payInstance.getCards().then(resolve)
    }
  );
  promise.then(
    value => {
      sendMessageToNative(platform, value, "getCards");
    },
    error => {
      sendMessageToNative(platform, error, "getCards");
      console.log('GetCards API rejected '+ error)
    }
  );
}

function encryptCard(platform, reqString) {
  console.log('inside encryptCard:')
  let cardData = JSON.parse(reqString);
  let promise = new Promise(
    function(resolve, reject) {
      click2payInstance.encryptCard(cardData).then(resolve)
    }
  );
  promise.then(
    value => {
      sendMessageToNative(platform, value, "encryptCard");
    },
    error => {
      sendMessageToNative(platform, error, "encryptCard");
      console.log('EncryptCard API rejected '+ error)
    }
  );
}

function idLookup(platform, reqString) {
  console.log('inside idLookup:')
  let request = JSON.parse(reqString);
  let promise = new Promise(
    function(resolve, reject) {
      click2payInstance.idLookup(request).then(resolve)
    }
  );
  promise.then(
    value => {
      sendMessageToNative(platform, value, "idLookup");
    },
    error => {
      sendMessageToNative(platform, error, "idLookup");
      console.log('IdLookup API rejected '+ error)
    }
  );
}

function initiateValidation(platform) {
  console.log('inside initiateValidation:')
  let promise = new Promise(
    function(resolve, reject) {
      click2payInstance.initiateValidation().then(resolve)
    }
  );
  promise.then(
    value => {
      sendMessageToNative(platform, value, "initiateValidation");
    },
    error => {
      sendMessageToNative(platform, error, "initiateValidation");
      console.log('InitiateValidation API rejected '+ error)
    }
  );
}

function validate(platform, reqString) {
  console.log('inside validate:')
  console.log('Validate request: '+reqString)
  let request = JSON.parse(reqString);
  let promise = new Promise(
    function(resolve, reject) {
      click2payInstance.validate(request).then(resolve)
    }
  );
  promise.then(
    value => {
      sendMessageToNative(platform, value, "validate");
    },
    error => {
      sendMessageToNative(platform, error, "validate");
      console.log('Validate API rejected '+ error)
    }
  );
}

function checkoutWithNewCard(platform, reqString, isDCFActionSheet) {
  console.log('inside checkoutWithNewCard:');
  console.log('is DCFActionSheet:'+ isDCFActionSheet);
  let checkoutRequest = JSON.parse(reqString);
  if (isDCFActionSheet == true)
        var iframe = document.getElementById("dcfLaunch");
  else
        var iframe = document.getElementById("dcfWeb");
  checkoutRequest.windowRef = iframe.contentWindow;
  console.log(checkoutRequest)
  function addClass() {
      iframe.classList.add('loaded')
   }
  iframe.addEventListener('load', addClass)
  let promise = new Promise(
    function(resolve, reject) {
      click2payInstance.checkoutWithNewCard(checkoutRequest).then(resolve)
    }
  );
  promise.then(
    value => {
      console.log("before dcf launch frame");
      iframe.removeEventListener('load',addClass)
      iframe.classList.remove('loaded')
      if (isDCFActionSheet == true)
              var frame = document.getElementById("dcfLaunch");
      else
              var frame = document.getElementById("dcfWeb");
      //var frame = document.getElementById("dcfLaunch");
      console.log("after dcf launch frame and before blank");
      frame.src = "about:blank"
      console.log("after blank");
      sendMessageToNative(platform, value, "checkoutWithNewCard");
    },
    error => {
      sendMessageToNative(platform, error, "checkoutWithNewCard");
      console.log('Checkout API rejected '+ error)
    }
  );
}

function checkoutWithCard(platform, reqString, isDCFActionSheet) {
  console.log('inside checkoutWithCard:');
  console.log('CheckoutRequest: '+ reqString);
  console.log('is DCFActionSheet:'+ isDCFActionSheet);
  let checkoutRequest = JSON.parse(reqString);
    if (isDCFActionSheet == true)
        var iframe = document.getElementById("dcfLaunch");
    else
        var iframe = document.getElementById("dcfWeb");
  checkoutRequest.windowRef = iframe.contentWindow;

  console.log(checkoutRequest)
  //  iframe.addEventListener('load', () => {
  //  console.log('Loaded iFrame listener')
  //  iframe.classList.add('loaded')
  //  })
  function addClass() {
    iframe.classList.add('loaded')
  }
  iframe.addEventListener('load', addClass)
  let promise = new Promise(
    function(resolve, reject) {
      click2payInstance.checkoutWithCard(checkoutRequest).then(resolve)
    }
  );
  promise.then(
    value => {
      iframe.removeEventListener('load', addClass)
      iframe.classList.remove('loaded')
      console.log('DCFLaunch ref: ', document.getElementById('dcfLaunch'))
      console.log('DCFLaunch ref: ', document.getElementById('dcfLaunch').classList)

      console.log("before dcf launch frame");
      if (isDCFActionSheet == true)
                var frame = document.getElementById("dcfLaunch");
      else
                var frame = document.getElementById("dcfWeb");
      console.log("after dcf launch frame and before blank");
      frame.src = "about:blank"
      console.log("after blank");
      sendMessageToNative(platform, value, "checkoutWithCard");
    },
    error => {
      sendMessageToNative(platform, error, "checkoutWithCard");
      console.log('Checkout API rejected '+ error)
    }
  );
}
