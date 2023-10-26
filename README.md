# SyncPoint
Term project for CMU 67-443: Mobile Application Development

Users: collection of documents representing people who use SyncPoint.
* last_name: String variable representing the user's last name. Taken from contacts.
* first_name: String variable representing the user's first name. Taken from contacts.
* email: String variable representing the user's email address. Taken from contacts.
* phone: String variable representing the user's phone number. Taken from contacts.
* picture: Image data for the user. Taken from contacts. Can be nil.
* tbd_events: list of Events whose final times are not yet established. Can be nil.
* upcoming_events: list of Events whose final times are established. Can be nil.
* notifications: list of Strings representing notifications.

Events: collection of documents representing created events organized in SyncPoint.
* name: String variable representing the name of the event.
* description: String variable representing the description of the event.
* participants: list of Users participating in the event.
* datespan: dictionary of Dates including the 'start' and 'end' of the timespan when availablility can be chosen.
* common_times: list of Dates where all participants are available. Can be nil.
* final_meeting_time: dictionary of Dates including the 'start' and 'end' of the event's decided time. Can be nil.
* host: User who created the event.

Availabilities: collection of documents representing the available times of users for a particular event.
* user: the relevant User.
* event: the relevant Event.
* indicated: Boolean value indicating whether availability has been filled out.
* times: list of Dates that the user has filled out being able to attend the event. Can be nil.
