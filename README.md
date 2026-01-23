# Motion Bridge

**motion_bridge** is a core FiveM utility resource developed for **Motion Scripts**.
It functions as a shared bridge that provides common functionality, exports, and compatibility layers used across all Motion Scripts resources.

Most Motion Scripts **require this resource** to run correctly.

## Requirements

* FXServer (FiveM)
* Motion Scripts
* ox_lib

---

## Installation

1. Download or clone the `motion_bridge` resource
2. Place the folder into your server `resources` directory
   Example:

   ```
   resources/[motion]/motion_bridge
   ```
3. Add the following line to your `server.cfg`:

   ```
   ensure motion_bridge
   ```
4. Make sure `motion_bridge` starts **before** any other Motion Scripts

---

## Usage

This resource is designed to run in the background and does not require direct interaction from server owners.

Other Motion Scripts will automatically:

* Call exports from `motion_bridge`
* Use shared utilities and helpers
* Rely on it for internal logic and compatibility

---

## Exports

Exports are intended for internal use by Motion Scripts scripts unless otherwise documented.

Example:

```
exports['motion_bridge']:FunctionName(arguments)
```

---

## Support

Support is provided **only** for legitimate Motion Scripts products.

If you encounter issues:

* Ensure `motion_bridge` is up to date
* Confirm it is started before dependent scripts
* Check your server console for errors

For additional support, contact Motion Scripts through our discord: https://discord.gg/jAbJ8rVUqw

---

## License

This resource is licensed for use **only** with Motion Scripts scripts.

* Redistribution is not permitted
* Modification is not permitted unless explicitly allowed
* Re-selling or leaking this resource is strictly prohibited

---

## Credits

Developed and maintained by **Motion Scripts**
All rights reserved.