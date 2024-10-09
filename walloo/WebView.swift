//
//  WebView.swift
//  iForget
//
//  Created by Vinícius Lopes on 25/09/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit
import Combine

struct WebView: UIViewRepresentable{
    
    @Binding var goForward: Bool
    @Binding var goBack: Bool
    @Binding var reloadPage: Bool
    @Binding var webTitle: String
    
    var url: String
    
    
    class Coordinator : NSObject, WKNavigationDelegate {
        
        
        @Binding var webTitle: String
        
        init( webTitle: Binding<String>) {
            _webTitle = webTitle
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            debugPrint("didCommit")
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            debugPrint("didFinish")
            
            self.webTitle = webView.title!
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            debugPrint("didFail")
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            return nil
        }
        
    }
    
    func makeCoordinator() -> WebView.Coordinator {
        return WebView.Coordinator(webTitle: $webTitle)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.navigationDelegate = context.coordinator
        wkWebView.allowsBackForwardNavigationGestures = true
        wkWebView.load(request)
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        if uiView.canGoBack, goBack {
            uiView.goBack() //go back if user tapped go back and last page is available
                    goBack = false
        }
        
        if uiView.canGoForward, goForward {
            uiView.goForward() //go back if user tapped go back and last page is available
                    goForward = false
        }
        
        if reloadPage {
            uiView.reload()
            reloadPage = false
        }
    }
}

