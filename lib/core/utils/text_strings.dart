class TextStrings{
  // Authentication
  static const String authentication_name_label = 'Name';
  static const String authentication_name_hint = 'Please enter your name';
  static const String authentication_name_error = 'Please enter a name';
  static const String authentication_email_label = 'Email';
  static const String authentication_email_hint = 'Enter a valid Email';
  static const String authentication_email_error = 'Please enter a valid email';
  static const String authentication_password_label = 'Password';
  static const String authentication_password_hint = 'Choose your Password';
  static const String authentication_password_error = 'Please enter a password';
  static const String authentication_register_message = 'Don´t have an account? ';
  static const String authentication_register_message_highlited = 'Register here';
  static const String authentication_login_button_value = 'Login';
  static const String authentication_signin_button_value = 'Create Account';
  static const String authentication_cancel_button_value = 'Cancel';
  static const String authentication_close_app_button_value = 'Close App';
  
  // Landing
  static const String landing_first_headline = 'Where to play near to you';
  static const String landing_second_headline = 'Your band';
  
  // Locals
  static const String locals_about_us_section_title = "About us";
  static const String locals_cta_button_value = "Contact";
  static const String locals_close_button_value = 'Close Profile';
  
  
  // Profile

  static const String profile_contact_section_title = 'How to reach me';
  static const String profile_contact_action_mail = 'Send Email';
  static const String profile_contact_action_whatsapp = 'Send WhatsApp';
  static const String profile_edit_description_hint = 'Tell us about you';
  static const String profile_description_section_title = 'About me';
  static const String profile_videos_section_title = 'How do I play?';
  static const String profile_edit_add_instrument_title = 'Select Your Instrument';
  static const String profile_edit_add_video_title = 'Add a video';
  static const String profile_edit_add_video_youtube_url_error = 'Insert a valid YouTube URL';
  static const String profile_edit_add_video_youtube_hint = 'https://www.youtube.com/watch?v=KzTeWPkUxQs';
  static const String profile_edit_add_video_ok_button = 'Accept';
  static const String profile_edit_add_video_ko_button = 'Cancel';
  static const String profile_instruments_section_title = 'What can I play?';
  static const String profile_edit_cta_buttons_ok_value = 'Accept';
  static const String profile_edit_cta_buttons_ko_value = 'Cancel';

  // Search
  static const String search_filters_section_title = 'Filters';
  static const String search_filter_segmented_control_members = 'Members';
  static const String search_filter_segmented_control_locals = 'Locals';
  static const String search_filter_search_label = 'Insert your search term';
  static const String search_filter_search_hint = 'Insert your search term';
  static const String search_filter_instruments_section_title = 'Instruments';
  static const String search_filter_distance_section_title = 'Distance';

  // Notifications
  static const String notifications_screen_title = 'Notifications';
  static const String notifications_sender_empty = 'Sender is empty';
  static const String notifications_actions_todo = 'Accept';
  static const String notifications_actions_done = 'Accepted';
  //Paterns
   static const Pattern youTubePattern = r'^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$';
}