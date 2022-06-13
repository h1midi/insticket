![Logo]([https://insticket.netlify.app/image/logo/logo-black.png](https://i.postimg.cc/gkwcDGC3/app-cover.png))
# Online ticketing system

### Team

- Mohammed Hamidi | Sidahmed Abdelaoui | Abdou Ammar | Mohammed Senouci.
---
2021/2022
---
## Tech Stack

**Client:** Flutter

**Server:** Firebase

## Conception

### Class Diagram
[![image.png](assets/images/classDiagram.drawio.png)

### MLD
**USER** (uId, mail, password, name, isAdmin).

**GAME** (id, title, description, stadium, date, covered_place_number,
covered_place_current,covered_place_price , normal_place_number, normal_place_current,
covered_place_price, home_team#, away_team#).

**TICKET** (code, Qr_code, isValid, type, price, uId#, gameId#).

**TEAM** (name, img_url).

Game (*) --- (Watch) --- (*) User :
**WATCH** (uid#, match_id#).

## Try it

[![Get it on Google Play](https://insticket.netlify.app/image/l3/google-play.png)](https://play.google.com/store/apps/details?id=com.team4.insticket)[![Website](https://insticket.netlify.app/image/l3/web-app.png)](https://web-insticket.netlify.app)
