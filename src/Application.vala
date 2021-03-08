public class MyApp : Gtk.Application {
    public MyApp () {
        Object (
            application_id: "com.github.ssmgcode.actions",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        set_accels_for_action ("app.quit", {"<Control>q", "<Control>w"});
        
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = _("GLib Action")
        };

        var headerbar = new Gtk.HeaderBar () {
            show_close_button = true
        };

        var button = new Gtk.Button.from_icon_name ("process-stop", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.quit",
            tooltip_markup = Granite.markup_accel_tooltip (
                get_accels_for_action ("app.quit"),
                "Quit"
            )
        };

        headerbar.add (button);

        main_window.set_titlebar (headerbar);
        main_window.show_all ();

        quit_action.activate.connect (() => {
            main_window.destroy ();
        });
    }

    public static int main (string[] args) {
        return new MyApp ().run (args);
    }
}
