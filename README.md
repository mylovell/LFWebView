# LFWebView


1. OC调用JS
		
		* [context evaluateScript:alertJS]
2. JS调用OC
		
		* 使用JavaScriptCore.framework框架
		* 使用自定义url方法
3. 获取webView中的源码内容
		
		* `[webView stringByEvaluatingJavaScriptFromString:titleString]`
		* 字符串：document.title等等




