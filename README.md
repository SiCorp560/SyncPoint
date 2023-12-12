# SyncPoint
## Term project for CMU 67-443: Mobile Application Development

SyncPoint is a mobile application developed for anyone who needs a platform for organizing meetings. Inspired by other scheduling tools such as When2Meet, SyncPoint allows you to create events and invite other users, have everyone select their available time slots, and plan out the final meeting time with ease.

### Design Decisions

We've done our best to create an application that takes advantage of the iPhone format. The application opens on a Google sign-in page that is easily filled out after the first time logging in. Every view beyond that can be navigated with minimal scrolling and tapping.

The Scheduled Events view displays both unfinished and finalized events in two lists. Vital information on each event, such as the number of participants who have filled out their times, are visible without any need to go further. Should more information be required, the user can easily swipe to a specific event in the list and then tap it to gain access. A button to create new events is easily accesible at the bottom of the screen.

The New Event and Edit Event views are similar, both allowing the host to fill in all necessary fields to set up an event. Most notably, the host can search up specific users to add as participants. Once the event is created, two sets of buttons need to be pressed in order to fully confirm the added event. Editing the event only requires one button, however.

The Event Details view contains less vital but still helpful information, such as the event description. Participants are listed out in more detail, while the final date and time remain TBD until a decision is made by the host. Depending on whether the user is the event host or a regular participant, options to view all other people's times and decide the final time may be present. This also applies to the Edit and Delete options at the top of the screen. Regardless of status, anyone can set their available times via another button.

The Select Availabilities view is a grid full of buttons that can be toggled to indicate availability at certain time slots. Though the small screen may need to be scrolled to access later times in the day, the confirmation button remains at the top for easy access by the user.

The View People's Times view is reserved for the host of an event only. Here, each button in the grid instead pulls up a popover window. This window displays whether each participant is available for that time slot or not. The buttons themselves also indicate this, due to their opacity changing depending on the number of participants who have checked that button on their own views.

### Tech Decisions

Many technical decisions had to be made in order to meet the deadline with a reasonable product. Overall, we decided that the data for our application should be handled with Firebase. We set up three models with corersponding collections on our database, to be queried as follows:

User.swift: struct representing a unique person registered with SyncPoint.
* id: unique String variable that identifies the user. Automatically created when user is added to Firebase.
* last_name: String variable representing the user's last name. Automatically filled during initial sign-in.
* first_name: String variable representing the user's first name. Automatically filled during initial sign-in.
* email: String variable representing the user's email address. Automatically filled during initial sign-in.
* phone: String variable representing the user's phone number.
* tbd_events: list of Strings matching the IDs of Events whose final times are not yet established.
* upcoming_events: list of Strings matching the IDs of Events whose final times are established.
* notifications: list of notification messages.

Event.swift: struct representing created events organized in SyncPoint.
* id: unique String variable that identifies the event. Automatically created when event is added to Firebase.
* name: String variable representing the name of the event.
* description: String variable representing the description of the event.
* participants: list of Strings matching the IDs of Users participating in the event.
* earliest_date: Date variable representing the earliest date in a span of seven days for the event.
* final_meeting_start: Date variable representing the start time of the event. Automatically set once the host selected the final time, but nil otherwise.
* final_meeting_end: Date variable representing the end time of the event. Automatically set once the host selected the final time, but nil otherwise.
* host: String variable matching the ID of the User who created the event.

Availabilities: struct representing the available times of a user for a particular event.
* id: unique String variable that identifies the availability. Automatically created when availability is added to Firebase.
* user: String variable matching the ID of the relevant User.
* event: String variable matching the ID of the relevant Event.
* times: list of Booleans that the user has filled out being able to attend the event.
* indicated: Boolean variable indicating whether availability has been filled out.

We had initially planned to implement access to the user's phone contacts, with that being the way to add participants to an event. However, with the addition of Google sign-in, we realized that accessing phone numbers when users had no guarantee of having a Google email was unreasonable. Instead, we decided to allow all users to be able to add any participant that has been registered on Firebase. The pool for this remains very small thanks to the necessity of a Gmail account.

The Select Availabilities view was intended to let the user drag their finger to select time slots. However, we found ourselves struggling to implement this feature without completely overhauling the existing grid format. Due to time constraints, we decided to scrap this feature.

### Testing

Testing has been limited to just the local methods within each of the important files in Data Repositories, Models, ViewModels, and Views. UI aspects were deemed unnecessary to test, since we could manually run the application and setting up for these tests would otherwise take up too much time.

We did attempt to test methods that involved accessing Firebase, however we quickly had to give those up. Proper testing requires us to establish a second database specifically for tests, rewrite all of our methods to connect to that database in particular, and create new repair functions to return the test database to its original state afterwards. This would take far too much time and resources on our end, so we did not pursue it.
