const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// Sample Firebase DB Trigger Function!
// exports.simpleDBFunction = functions.database.ref('/Users/{userID}/signals/inviteSignal').onUpdate((change, context) => {
// 	console.log(change.after.child('game').val(), 'written by', context.auth.uid)

// 	return true
// })

var db = admin.database();
var usersRef = db.ref('/Users')

// Values for sending notifications
var currentUsername = String()
var notificationMessage = String()

exports.sendOnlineNotifications = functions.database.ref('/Users/{userID}/signals/onlineSignal/deviceTokens').onCreate((snapshot, context) => {
	let deviceTokens = snapshot.val()
	console.log('Sending to these devices ' + deviceTokens)





	return true
})

exports.sendInviteNotification = functions.database.ref('/Users/{userID}/signals/inviteSignal/deviceToken').onCreate((snapshot, context) => {
	let deviceToken = snapshot.val()

	var currentUserRef = usersRef.child(context.params.userID)
	currentUserRef.on('value', function(snapshot) {

		currentUsername = snapshot.child('username').val();
		notificationMessage = snapshot.child('/signals/inviteSignal/message').val();

		var payload = {
				notification: {
					title: 'Invite from' + ' ' + currentUsername,
					body: notificationMessage,
					}
			}


		admin.messaging().sendToDevice(deviceToken, payload)
			.then((response) => {
			console.log('Successfully sent notification:', response)
			})
			.catch((error) => {
				console.log('Error sending message:', error)
			})

		console.log('notification sent from:', currentUsername, 'notification sent to:', deviceToken, 'message body:', notificationMessage)

	})



	return true
})
