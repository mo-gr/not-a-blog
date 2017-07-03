---
layout: post
title: "Type Hints"
date: 2012-04-16 22:59
comments: true
external-url: 
categories: coding IntelliJ IDEA
---
Today, [Matthias Naber](mana) made me aware of [IntelliJ](idea) type hints in JSF and JSP files.

[IntelliJ](idea) does quite a good job in figuring out the types of EL variables itself, providing code completion and usage information. But there are situations where [IDEA](idea) is unable determine the type of an EL variable. This usually occurs to me in a facelet `composition` where the variables are passed in as a `param`.

The following is a basic facelt composition invocation:

    <ui:include src="toiletten.xhtml">
        <ui:param name="toilette" value="#{umkleide.toiletten}"/>
    </ui:include>

In the file containing the invocation, [IDEA](idea) is fully aware of the type of the EL variables. However in the included file (toiletten.xhtml), which might look something like this:

    <html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://java.sun.com/jsf/html" 
      xmlns:ui="http://java.sun.com/jsf/facelets">
      <ui:composition>
        <h:outputLabel value="#{toilette.ppBecken}"/>
      </ui:composition>
    </html>
   
[IntelliJ](idea) is unable to infere the type of the EL variable `toilette`. It is therefore neither able to offer me code completion nor warn me about typos and errors. It might even mark the getter `getPpBecken()` in the Toilette as unused.

However, if you help [IDEA](idea) a little bit by hinting the type, all the goodness is restored. Just add the following, proprietary comment somewhere in the file:

        <!--@elvariable id="toilette" type="com.notadomain.datamodel.Toiletten"-->

This comment tells [IntelliJ](idea) the type of the EL variable, enabling autocompletion, usage indexing and of course only marking true errors in the file.

If you are using JSPs, the comment should probably look something like:

        <%--@elvariable id="toilette" type="com.notadomain.datamodel.Toiletten"--%>

If you are somehow worried about putting proprietary comments in your files, _you_ have some weird issues. But nonetheless, those comments, at least in facelets, even work outside of the `composition`-tag, which will make them become ignored anyway.

    <html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://java.sun.com/jsf/html" 
      xmlns:ui="http://java.sun.com/jsf/facelets">
      <!--@elvariable id="toilette" type="com.notadomain.datamodel.Toiletten"-->
      <ui:composition>
        <h:outputLabel value="#{toilette.ppBecken}"/>
      </ui:composition>
    </html>

A properly configured [IntelliJ](idea) setup will help you so many times a day. You are going to be a _lot_ more productive. It is absolutely worth, adding some comments and guides to make the warnings and analyzations of your IDE more precise and focussed. 

If I had gotten a coin for every time, I fixed a bug, that was already underlined and critized by [IDEA](idea) when I found it, I'd have an aweful lot of coins.

Use your tools to their full advance and don't check in code that contains warnings! I really wish, there would be something like the `-Werror` flag in `javac`!

[mana]: https://plus.google.com/107214795663348726883
[idea]: http://www.jetbrains.com/idea/