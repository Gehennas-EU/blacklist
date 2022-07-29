# Gehennas Blacklist Data

This repository contains list of blacklisted characters on WoW Classic Gehennas EU server.

## Table of contents

- [Gehennas Blacklist Data](#gehennas-blacklist-data)
	- [Table of contents](#table-of-contents)
	- [Installation](#installation)
	- [How to add characters to the list](#how-to-add-characters-to-the-list)
	- [How the ban bot works](#how-the-ban-bot-works)
	- [Ho the unban bot works](#ho-the-unban-bot-works)

## Installation

The addon is available on

- [Wago.io](https://addons.wago.io/addons/blacklist)

## How to add characters to the list

Open a new [Blacklist Request issue](https://github.com/Gehennas-EU/blacklist/issues/new/choose) and follow the instructions.

Admins then can respond with the `/ban` command and the changes would be automatically added to [the blacklist file](blacklist.lua).

## How the ban bot works

The bot reacts to messages set in issues by administrators of this repository. The full syntax of the ban command is

```
/ban list=name_of_list reason="Some reason" discord=https://discord...... banned_player_1 banned_player_2 banned_player_3
```

Only `list` and at least 1 banned player is required. For example:

```
/ban list=official reason="Deathroll scammer" Javoor
```

## Ho the unban bot works

The bot reacts to messages set in issues by administrators of this repository. The full syntax of the ban command is

```
/ban list=name_of_list banned_player_1 banned_player_2 banned_player_3
```

Only `list` and at least 1 banned player is required. For example>

```
/unban list=official Javoor
```
