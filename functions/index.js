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


exports.sendRequestNotification = functions.database.ref('/Users/{userID}/requests/{requestID}').onCreate((snapshot, context) => {

	const requestID = context.params.requestID
	const currentUserID = context.params.userID

	usersRef.child(currentUserID).once('value', function(snapshot) {
		const token = snapshot.child('fcmToken').val()
		const username = snapshot.child('username').val()

		notificationMessage = "You have a new friend request!"
		var payload = {
			notification: {
				title: "Gump",
				body: notificationMessage
			}
		}

		return admin.messaging().sendToDevice(token, payload).then(ok => {
			console.log(ok)
		})
		.catch(err => {
			console.error(error)
		})
	})

	return true

})


exports.sendOnlineNotifications = functions.database.ref('/Users/{userID}/signals/onlineSignal/deviceTokens').onCreate((snapshot, context) => {
	let deviceTokens = snapshot.val()

	var currentUserRef = usersRef.child(context.params.userID)
	currentUserRef.on('value', function(snapshot) {

		currentUsername = snapshot.child('username').val()
		let currentGame = snapshot.child('/signals/onlineSignal/game').val()
		let currentConsole = snapshot.child('/signals/onlineSignal/console').val()

		notificationMessage = currentUsername + " is about to get online and play " + currentGame + " for " + currentConsole

		var payload = {
			notification: {
				title: "Online Singal",
				body: notificationMessage,
			}
		}

		admin.messaging().sendToDevice(deviceTokens, payload)
			.then((response) => {
			console.log('Successfully sent notification:', response)
			})
			.catch((error) => {
				console.log('Error sending message:', error)
			})



	})



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
					title: 'Invite Signal from' + ' ' + currentUsername + "!",
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
