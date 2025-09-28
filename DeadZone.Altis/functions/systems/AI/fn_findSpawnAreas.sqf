/*
    --------------------------------
    this is not needed anymore, kept for reference
    --------------------------------
    fn_findSpawnAreas.sqf
    --------------------------------
    Scans all map markers for tier tags and collects their positions and sizes. 
    Stores the collected data in missionNamespace variables for later use.
    Tags used: @HighTier, @MiddleTier, @LowTier
    
    Example usage:
        private _allMarkers = missionNamespace getVariable ["MarkersByTier", []];

        // Filter MiddleTier markers
        private _midMarkers = _allMarkers select {_x select 0 == "MiddleTier"};

        if (count _midMarkers > 0) then {
            private _entry = selectRandom _midMarkers;
            private _markerName = _entry select 1;
            private _markerPos  = _entry select 2;
            private _markerSize = _entry select 3;
            private _maxGroups  = _entry select 4;

            // Spawn _maxGroups units at _markerPos
        };
    private _spawnAreas = [] call DeadZone_Functions_fnc_findSpawnAreas;
*/



// Collect markers based on name "Tier,MaxGroups" and hide them
private _markersData = []; // [tier, markerName, pos, size, maxGroups]   

{
    _x setMarkerAlpha 0;
    private _name = markerName _x;
    if (_name find "," > -1) then {
        private _parts = _name splitString ",";
        private _tier = _parts select 0;
        private _maxGroups = parseNumber (_parts select 1);
        private _pos = markerPos _x;
        private _size = markerSize _x;

        _markersData pushBack [_tier, _x, _pos, _size, _maxGroups];
    };
} forEach allMapMarkers;

// store globally for later use
missionNamespace setVariable ["MarkersByTier", _markersData, true];

// return result
_markersData
