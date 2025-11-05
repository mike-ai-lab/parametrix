developer-focused rule set 

---

### Optimized Loader & Update Rules

**1. Unique Identifier Policy**

* Every update **must** include a unique identifier to avoid conflicts with versioning.
* The unique identifier is appended to:

  * Menu item name
  * Dialog box title
  * Console log messages
* Format: `"P-5 <your_unique_id>"` (example: `"P-5 v1.2.3_20251105"`).
* Do **not** skip the unique identifier, but do not create extra unnecessary files just to satisfy uniqueness.

**2. Loader Behavior**

* Always **clear cached modules** to ensure the most recent code is loaded.
* Automatically **update the menu item** and **toolbar** after loading.
* Always retain existing features.
* Always **fix broken behavior**, do **not** remove features as a shortcut.

**3. Console & Dialog Logging**

* Use the unique identifier in all logs and dialog boxes to track versions.
* Example log: `[PARAMETRIX P-5 v1.2.3_20251105] Module loaded successfully.`

**4. Loader Command (Ruby / SketchUp)**

```ruby
# Strong loader for Parametrix P-5 extension
def load_parametrix(loader_path, unique_id)
  model = Sketchup.active_model

  # Clear previously loaded modules
  if defined?(PARAMETRIX)
    PARAMETRIX.constants.each { |c| PARAMETRIX.send(:remove_const, c) }
  end

  # Force reload of the main extension file
  load loader_path

  # Update menu & toolbar with unique identifier
  menu_name = "P-5 #{unique_id}"
  toolbar_name = "P-5 #{unique_id}"
  
  # Remove old menu if exists
  UI.menu("Plugins").remove_item(menu_name) rescue nil
  # Add new menu
  UI.menu("Plugins").add_item(menu_name) { puts "[PARAMETRIX #{menu_name}] Activated." }

  # Update toolbar (simplified, for standard SketchUp toolbar)
  toolbar = UI::Toolbar.new(toolbar_name)
  # Add commands or buttons as needed here
  toolbar.show

  # Log load confirmation
  puts "[PARAMETRIX #{menu_name}] Loader executed successfully."
end

# Example usage:
# load_parametrix("C:/Users/mshke/Documents/Automations/PARAMETRIX_EXTENSION/parametrix_p5.rb", "v1.2.3_20251105")
```

**5. Developer Notes**

* Always append `unique_id` when creating or updating modules.
* Never remove existing features; always fix problems in place.
* Clearing constants ensures no old versions interfere with the update.
* Menu and toolbar names include the unique identifier to track which version is loaded.
* All these should be at the end of the task, never start with theme, always focis on the task from the user and when finishing it u proceed with the rules seamlessly without wasting time
---

