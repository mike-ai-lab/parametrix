
## PARAMETRIX – Loader & Update Rules (Finalized)

### 1. Unique Identifier Policy

* Every new update of the extension **must include a unique identifier**:
  `P-(next version number)`
  Example: if the last version folder is `P-4`, the next is `P-5`.
* The identifier appears in:

  * Menu item
  * Dialog titles
  * Console logs
* The loader **must** be updated to match the current identifier.
* No need to create random folders or timestamps—just increment the number properly.

---

### 2. Loader Behavior

* Clear **previously cached modules** to prevent SketchUp from using old code.
* After loading, automatically update:

  * Plugin menu item
  * Toolbar
* Existing features remain intact.
  Bugs are fixed **directly**—never removed.

---

### 3. Console & Dialog Logging

* All logs use the identifier so it is always clear which version is running.
* Example:
  `[PARAMETRIX P-5] Module loaded successfully.`

---

### 4. Loader Command (SketchUp Ruby)

This is the finalized, corrected loader function.
It takes the loader file path and the version identifier (e.g., `"P-5"`):

```ruby
# Strong loader for Parametrix version P-X
def load_parametrix(loader_path, version_id)
  # Clear cached PARAMETRIX modules
  if defined?(PARAMETRIX)
    PARAMETRIX.constants.each { |c| PARAMETRIX.send(:remove_const, c) }
  end

  # Reload the main extension file
  load loader_path

  # Naming based on version
  menu_name    = version_id
  toolbar_name = version_id

  # Refresh menu item
  plugins_menu = UI.menu("Plugins")
  plugins_menu.remove_item(menu_name) rescue nil
  plugins_menu.add_item(menu_name) {
    puts "[PARAMETRIX #{menu_name}] Menu activated."
  }

  # Refresh toolbar
  toolbar = UI::Toolbar.new(toolbar_name)
  # Toolbar buttons can be re-added here if needed
  toolbar.show

  # Console confirmation
  puts "[PARAMETRIX #{menu_name}] Loader executed successfully."
end

# Example usage:
# load_parametrix("C:/Users/mshke/Documents/Automations/PARAMETRIX_EXTENSION/parametrix_p5.rb", "P-5")
```

---

### 5. Developer Notes

* Always increment the version properly: P-4 → P-5 → P-6 …
* Always update the loader with the new identifier.
* Always fix problems within the existing feature set.
* Never drop features because a fix is hard—repair, don’t remove.
* Clearing cached constants guarantees SketchUp loads the latest code.
* Menu + Toolbar showing the identifier makes it easy to verify the loaded version.
* Loader rules come **after completing the main task**, not before.
