### iOS integration of Web Javascript SDK

Mastercard Javascript library provides Client-side APIs to complete Click-to-Pay checkout experience.
Merchant partners can use this Sample Merchant application as a guide to integrate Mastercard Javascript library with native mobile application.

### Table of Contents
- [Overview](#overview)
- [Steps to Integrate](#overview)
- [Communication between Native and Web layer](#communication)
- [Checkout Flows](#checkout)
- [DCF Action Sheet](#actionSheet)

### <a name="overview">Overview</a>
The sample app shows integration of Mastercard Javascript methods which can be used to perform Recognized User, Recognition of a User through Email lookup or First Time User Checkout flow. 
Integrators can test the different checkout flows from the sample Merchant screen as below:

![Web Integration](Web-Native-Integration-iOS/iOSWebSDK.png)

1. Download Mastercard Javascript library by adding ````<script>```` tag on ````index.html```` 

```html
<script src="https://sandbox.src.mastercard.com/srci/merchant/2/lib.js?dpaId={DpaId}&locale=en_US"></script>
```

2. Add ````srcDpaId```` on ````NewMerchantViewController.swift```` 

 <b>IMPORTANT:</b> Do not build the sample app without providing ````srcDpaId````. Failing to do so will block user from calling any Mastercard APIs.
 
 ```html
 var srcDpaId = ""
 ```

 It is important to have the same DpaId on both ````index.html```` and ````NewMerchantViewController.swift```` before building the Sample app. 

### <a name="communication">Communication between Native and Web layer</a>
1. <b>Native to Web Layer: </b> API calls from native layer are invoked by calling the ````evaluateJavascript```` method on webView object. 

Merchant application converts the request object to JSON string before invoking Javascript APIs.

<b>Example: </b> init API called from WebViewIntegration.swift and API invocation completes on Javascript library.

````html
self.evaluateJavaScript("initSdk(\"ios\", JSON.stringify(\(initRequestString)))")
````

2. <b>API call inside Web layer: </b>

<b>Example: </b> init API being invoked on click2Pay object provided by Mastercard Javascript library.

````html
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
````
3. <b>Web Layer to Native: </b> Once the API call is complete, the results are passed back to native layer from web layer using WebView.JavascriptInterface
   
Example: init API results being sent from javascript function back to Native Android activity. Results are received on JavascriptInterface on Android Activity.

    function sendMessageToNative(json, methodName){
      console.log("sending value to native...")
        var formattedJSON = JSON.stringify(json, null, 2);
        window.webkit.messageHandlers.jsMessageHandler.postMessage(formattedJSON);
    }
    
### <a name="checkout">Checkout Flows</a>
1. <b>New User Checkout</b> - To test this checkout flow call APIs in this order on Sample App: init, encryptCard, checkoutWithNewCard. Once checkout is initiated, this will launch DCF window and user can complete checkout.

2. <b>Return User Checkout (Unrecognized flow) </b> - To test this checkout flow call APIs in this order on Sample App: init, idLookup, initiateValidation, validate, getCards, checkoutWithCard

3. <b>Recognized User Checkout(Remembered User flow) </b> - To test this checkout flow either New user checkout or Return user checkout flow must be completed with "Remember Me" option selected during checkout experience. 
   Now the cookie is persisted on webView and user can test Recognized user flow by calling these APIs - init, getCards, checkoutWithCard  

### <a name="actionSheet">DCF Action sheet</a>  

Sample app provides optional styling of DCF window to be displayed as action sheet. This action sheet style mode can be enabled/disabled by selecting the checkbox located on top of the Merchant screen.  

DCF Action Sheet Mode            |           DCF Regular Mode  
:---------------------:          |        :---------------------:
![Action Sheet](Web-Native-Integration-iOS/actionSheet.png) | ![Regular Sheet](Web-Native-Integration-iOS/regular.png)   
   
