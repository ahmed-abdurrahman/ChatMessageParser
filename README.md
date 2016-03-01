# ChatMessageParser

String demo parser app parses & converts chat message strings into a JSON string containing information about its contents.
     
     Special content to look for includes:
     
     1. @mentions - A way to mention a user. Always starts with an '@' and ends when hitting a non-word character. (http://help.hipchat.com/knowledgebase/articles/64429-how-do-mentions-work-)
     2. Emoticons - For this exercise, you only need to consider 'custom' emoticons which are alphanumeric strings, no longer than 15 characters, contained in parenthesis. You can assume that anything matching this format is an emoticon. (https://www.hipchat.com/emoticons)
     3. Links - Any URLs contained in the message, along with the page's title.
     Note, URLs must start with http or www

     # Example
     - Input: "@chris, good morning! (megusta) (coffee). See this:  http://www.nbcolympics.com"
     - Return (string):
     {
        "mentions": [
             "chris"
         ],
        "emoticons": [
            "megusta",
            "coffee"
        ],
         "links": [{
            "url": "http://www.nbcolympics.com",
            "title": "NBC Olympics | 2014 NBC Olympics in Sochi Russia"
         }]
     }
