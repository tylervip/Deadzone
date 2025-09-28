/*
    fn_findSpawnAreasInAO.sqf
    Finds all markers named "Tier,MaxGroups" inside the selected AO
    Stores results in missionNamespace for later AI spawning
    Returns: array of [tier, markerName, pos, size, maxGroups]

Example Usage for AI Spawning
    // get all markers in the selected AO
private _spawnMarkers = [] call DeadZone_Functions_fnc_findSpawnAreasInAO;

// filter by tier (optional)
private _midMarkers = _spawnMarkers select {_x select 0 == "MiddleTier"};

if (count _midMarkers > 0) then {
    // pick a random marker
    private _entry = selectRandom _midMarkers;
        private _markerName = _entry select 1;
        private _markerPos  = _entry select 2;
        private _markerSize = _entry select 3;
        private _maxGroups  = _entry select 4;

    // spawn AI units according to _maxGroups
    {
        _unit = createUnit ["B_Soldier_F", _markerPos, [], 0, "NONE"];
    } for "_i" from 1 to _maxGroups;
};
*/

private _selectedMarkerName = missionNamespace getVariable ["AO_Marker", ""];

if (_selectedMarkerName isEqualTo "") exitWith {
    systemChat "No AO marker selected!";
    [];
};

private _aoPos  = markerPos _selectedMarkerName;
private _aoSize = markerSize _selectedMarkerName; // [width, height]

private _markersInAO = [];

{
    private _name = markerName _x;
    if (_name find "," == -1) exitWith {}; // skip markers without Tier,MaxGroups

    private _parts = _name splitString ",";
    private _tier = _parts select 0;
    private _maxGroups = parseNumber (_parts select 1);
    private _pos = markerPos _x;
    private _size = markerSize _x;

    // check if marker is inside AO rectangle
    private _halfWidth  = _aoSize select 0 / 2;
    private _halfHeight = _aoSize select 1 / 2;

    private _dx = abs ((_pos select 0) - (_aoPos select 0));
    private _dy = abs ((_pos select 1) - (_aoPos select 1));

    if (_dx <= _halfWidth && _dy <= _halfHeight) then {
        _markersInAO pushBack [_tier, _x, _pos, _size, _maxGroups];
        _x setMarkerAlpha 0; // hide marker
    };
} forEach allMapMarkers;

// store globally for later spawning
missionNamespace setVariable ["MarkersInSelectedAO", _markersInAO, true];

// return result
_markersInAO