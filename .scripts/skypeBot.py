import Skype4Py, httplib, urllib

# List of highlight words for pushover
highlights = [
	"bob",
	"robert",
	"bobby",
	"booby",
	"boobies",
]

badWords = [
	"fuck",
	"shit",
	"damn",
	"dick",
	"ass",
	"cunt",
	"piss",
	"cock",
	"bastard",
]

# pushover tokens for JSON object
userToken = "[Token Goes Here]"
apiToken = "{Token Goes Here]"

# Create an instance of the Skype class.
skype = Skype4Py.Skype()

# Connect the Skype object to the Skype client.
skype.Attach()

# Define methods
def help(index):
	output = ""
	output += "[+] Available Commands:\n"
	output += "[-] !help -- List this help menu\n"
	output += "[-] !listmembers -- Print the list of members currently in chat\n"
	output += "[-] !hello -- Greets the user that issues the command\n"
	output += "[-] !emptyswearjar -- empties the swear jar\n"
	skype.Chats[index].SendMessage(output)

def listMembers(index):
	output = ""
	output += "[+] Members of chat \"" + skype.Chats[index].Topic + "\"\n"
	for member in skype.Chats[index].Members:
				output += member.Handle + " aka " + str(member.FullName) + "\n"
				output +="-    Online: " + member.OnlineStatus + "\n"
				output +="-    Last Online: " + str(member.LastOnlineDatetime) + "\n"
				output +="-    Phone Number: " + str(member.PhoneMobile) + "\n"
				output +="-    Number of Friends: " + str(member.NumberOfAuthBuddies) + "\n"
				output +="-    Call Equipment: " + str(member.HasCallEquipment) + "\n"
				output +="-    Webcam: " + str(member.IsVideoCapable) + "\n"
	skype.Chats[index].SendMessage(output)

def main():

	swearJar = 0;

	while True:
		messages = []
		for chat in skype.Chats:
			if (len(chat.RecentMessages) <= 0):
				messages.append("Null")
			else:
				messages.append(chat.RecentMessages[len(chat.RecentMessages) -1 ].Body)
		loop = True

		while loop:
			checkForNewMessages = []
			index = 0
			for chat in skype.Chats:
				if (messages[index] != "Null"):
					try:
						if (messages[index] != chat.RecentMessages[len(chat.RecentMessages) -1 ].Body):
							loop = False
							newMessage = skype.Chats[index].RecentMessages[len(skype.Chats[index].RecentMessages) -1]

							# Detect highlight words and send pushover notification
							for highlight in highlights:			
								if (highlight in newMessage.Body):
									conn = httplib.HTTPSConnection("api.pushover.net:443")
									conn.request("POST", "/1/messages.json",
									  urllib.urlencode({
									    "token": apiToken,
									    "user": userToken,
									    "message": newMessage.Body,
									    "title": newMessage.FromHandle,
									  }), { "Content-type": "application/x-www-form-urlencoded" })
									conn.getresponse()
									break

							for highlight in badWords:			
								if (highlight in newMessage.Body.lower()):
									swearJar += 0.25
									message = "User " + newMessage.FromHandle + " said a bad word!\n"
									message += "The swear jar's current total is $" + str(swearJar)
									skype.Chats[index].SendMessage(message)
									break

							# Detect if newest message is a command ('!' identifier)
							if (newMessage.Body[0] == '!'): 
								userName = newMessage.FromHandle
								command = newMessage.Body[1:].lower()

								skype.Chats[index].SendMessage("[+] (" + userName + "): Executing Command...")
								if ("hello" in command):
									skype.Chats[index].SendMessage("Hello " + userName)
								elif ("listmembers" in command):
									listMembers(index)
								elif ("help" in command):
									help(index)
								elif ("emptyswearjar" in command):
									if (userName != "bob.legrand"):
										skype.Chats[index].SendMessage("You don't have the authority to empty the swear jar!")
									else:
										swearJar = 0
								else:
									skype.Chats[index].SendMessage("[+] (" + userName + "): Command not recognized: " + command)
					except IndexError:
						pass

				index += 1


if(__name__ == "__main__"):
	main()