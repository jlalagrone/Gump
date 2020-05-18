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

exports.sendInviteNotification = functions.database.ref('/Users/{userID}/signals/inviteSignal/toUID').onCreate((snapshot, context) => {
	let userID = snapshot.val()

	var currentUserRef = usersRef.child(context.params.userID)
	currentUserRef.on('value', function(snapshot) {

		currentUsername = snapshot.child('username').val();
		notificationMessage = snapshot.child('/signals/inviteSignal/message').val();

		console.log('notification sent from:', currentUsername, 'notification sent to:', userID, 'message body:', notificationMessage)

	})

	var toUserRef = usersRef.child(userID)
	toUserRef.on('value', function(snapshot) {

		let fcmToken = snapshot.child('fcmToken').val();
		console.log(fcmToken)

		var payload = {
				notification: {
					title: 'Invite from' + ' ' + currentUsername,
					body: notificationMessage,
					}
			}
			


		admin.messaging().sendToDevice(fcmToken, payload)
			.then((response) => {
			console.log('Successfully sent notification:', response)
			})
			.catch((error) => {
				console.log('Error sending message:', error)
			})

	})


	return true
})
