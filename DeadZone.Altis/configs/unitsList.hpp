// unitsList.hpp
// Defines unit configurations for HighTier (AAF), MiddleTier (FIA), and LowTier (Syndicate Bandits)
// Used for spawning AI enemies in the Dynamic AO System with specific skill levels

class UnitTiers {
    class HighTier {
        // High tier units for key defended areas or COPs (AAF, IND_F)
        class Infantry {
            units[] = {
                "I_Soldier_SL_F",        // Squad Leader
                "I_Soldier_TL_F",        // Team Leader
                "I_Soldier_AT_F",        // Missile Specialist (AT)
                "I_Soldier_M_F",         // Marksman
                "I_Soldier_AR_F",        // Autorifleman
                "I_medic_F",             // Combat Life Saver
                "I_Soldier_exp_F"        // Explosive Specialist
            };
            skillLevel = 0.8;            // Higher skill for challenging AI
        };
    };

    class MiddleTier {
        // Middle tier units for guerrilla areas (FIA, BLU_G_F)
        class Infantry {
            units[] = {
                "B_G_Soldier_TL_F",      // Team Leader
                "B_G_Soldier_LAT_F",     // Rifleman (Light AT)
                "B_G_Soldier_M_F",       // Marksman
                "B_G_Soldier_AR_F",      // Autorifleman
                "B_G_medic_F",           // Medic
                "B_G_Soldier_F"          // Rifleman
            };
            skillLevel = 0.6;            // Moderate skill for guerrilla AI
        };
    };

    class LowTier {
        // Low tier units for bandit areas (Syndicate, IND_C_F)
        class Infantry {
            units[] = {
                "I_C_Soldier_Bandit_3_F", // Rifleman
                "I_C_Soldier_Bandit_1_F", // Machinegunner
                "I_C_Soldier_Bandit_5_F", // Hunter
                "I_C_Soldier_Para_3_F",   // Paramilitary Marksman
                "I_C_Soldier_Bandit_7_F", // Thug
                "I_C_Soldier_Para_1_F"    // Paramilitary Rifleman
            };
            skillLevel = 0.4;            // Lower skill for less challenging AI
        };
    };
};