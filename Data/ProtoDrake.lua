DWMS_PROTODRAKE = {
    name = 'Renewed Proto-Drake',
    categoryNames = {
        'Full Transformation',
        'Skin Color',
        'Skin Scale Type',
        'Pattern',
        'Horns',
        'Horn Color',
        'Horn Style',
        'Tail',
        'Throat',
        'Body Armor',
        'Head Armor',
        'Armor Color',
        'Snout',
        'Crest',
        'Jaw',
        'Brow',
        'Hair Color',
    },
    manuscripts = {
        -- Full Transformation
        {
            -- Embodiment of the Storm-Eater
            { itemId = 201790, questId = 72367, source = { name = "Vault of the Incarnates", note = "Raszageth, the Storm-Eater " } }
        },
        -- Skin Color
        {
            -- Black
            { itemId = 197392, questId = 69593, sources = { { coords = { zone = DWMS_ZONE.WAKING_SHORES, x = 25.2, y = 55.8 }, name = "Lorena Belle <Wrathion\'s Quartermaster>", note = "True Friend with Wrathion or Sabellian", cost = { { type = "item", id = 190316, count = 1 }, { type = "currency", id = 2003, count = 400 } } } } },
            -- Blue
            { itemId = 197390, questId = 69591, sources = { { coords = { zone = DWMS_ZONE.AZURE_SPAN, x = 13.0, y = 49.2 }, name = "Murik", note = "Iskaara Tuskarr - Renown 19", cost = { { type = "item", id = 190329, count = 1 }, { type = "currency", id = 2003, count = 400 } } } } },
            -- Green
            { itemId = 197389, questId = 66720, sources = { { coords = { zone = DWMS_ZONE.OHNAHRAN_PLAINS, x = 60.4, y = 37.6 }, name = "Quartermaster Huseng", note = "Maruuk Centaur - Renown 19", cost = { { type = "item", id = 190327, count = 1 }, { type = "currency", id = 2003, count = 400 } } } } },
            -- Bronze
            { itemId = 197391, questId = 69592, sources = { { coords = { zone = DWMS_ZONE.VALDRAKKEN, x = 46.8, y = 78.8 }, name = "Kaestrasz", note = "Valdrakken Accord - Renown 21", cost = { { type = "item", id = 190324, count = 1 }, { type = "currency", id = 2003, count = 400 } } } } },
            -- White
            { itemId = 197393, questId = 69594, hidden = true },
        },
        -- Skin Scale Type
        {
            -- Heavy
            { itemId = 197397, questId = 69593, sources = { { coords = { zone = DWMS_ZONE.WAKING_SHORES, x = 25.9, y = 57.4 }, name = "Neltharus", drop = "Warlord Sargha" } } },
        },
        -- Pattern
        {
            -- Predator
            { itemId = 197394, questId = 69595, sources = { { name = "Inscription" } } },
            -- Harrier
            { itemId = 197395, questId = 69596, sources = { { coords = { zone = DWMS_ZONE.WAKING_SHORES, x = 25.2, y = 55.8 }, name = "Cataloger Jakes", note = "Dragonscale Expedition - Renown 15", cost = { { type = "currency", id = 2003, count = 100 } } } } },
            -- Skyterror
            { itemId = 197396, questId = 69597, sources = { { coords = { zone = DWMS_ZONE.AZURE_SPAN, x = 11.5, y = 49.1 }, name = "Brackenhide Hallow", drop = "Decay Tainted Chest" } } },
        },
        -- Horns
        {
            -- Swept
            { itemId = 197374, questId = 69575 },
            -- Curled
            { itemId = 197375, questId = 69576 },
            -- Ears
            { itemId = 197376, questId = 69577 },
            -- Bovine
            { itemId = 197377, questId = 69578 },
            -- Subtle
            { itemId = 197378, questId = 69579 },
            -- Impaler
            { itemId = 197379, questId = 69580 },
            -- Curved Spiked
            { itemId = 197380, questId = 69581 },
            -- Malevolent
            { itemId = 202279, questId = 73056 },
            -- Bruiser
            { itemId = 202277, questId = 73057 },
            -- Antler
            { itemId = 202278, questId = 73058 },
        },
        -- Horn Color
        {
            -- White
            { itemId = 197382, questId = 69583 },
            -- Gradient
            { itemId = 197381, questId = 69582 },
        },
        -- Horn Style
        {
            -- Heavy
            { itemId = 197383, questId = 69584 },
        },
        -- Tail
        {
            -- Spiked Club
            { itemId = 197402, questId = 69603 },
            -- Club
            { itemId = 197403, questId = 69604 },
            -- Finned
            { itemId = 197404, questId = 69605 },
            -- Maned
            { itemId = 197405, questId = 69606 },
            -- Spined
            { itemId = 197406, questId = 69607 },
            -- Pronged
            { itemId = 202280, questId = 73060 },
        },
        -- Throat
        {
            -- Spiked
            { itemId = 197407, questId = 69608 },
            -- Finned
            { itemId = 197408, questId = 69609 },
        },
        -- Body Armor
        {
            -- Armor
            { itemId = 197357, questId = 69558 },
        },
        -- Head Armor
        {
            -- Helm
            { itemId = 197373, questId = 69574, hidden = true },
        },
        -- Armor Color
        {
            -- Black
            { itemId = 197346, questId = 69547 },
            -- Blue
            { itemId = 197347, questId = 69548 },
            -- Purple
            { itemId = 197350, questId = 69551 },
            -- Red
            { itemId = 197351, questId = 69552 },
            -- Gold
            { itemId = 197352, questId = 69553 },
            -- Gold and White
            { itemId = 197349, questId = 69550, hidden = true },
            -- Black and Red
            { itemId = 197348, questId = 69549, hidden = true },
            -- Bronze and Pink
            { itemId = 197353, questId = 69554, hidden = true },
        },
        -- Snout
        {
            -- Snub
            { itemId = 197398, questId = 69559 },
            -- Razor
            { itemId = 197399, questId = 69600 },
            -- Shark
            { itemId = 197400, questId = 69601 },
            -- Beaked
            { itemId = 197401, questId = 69602 },
            -- Stubby
            { itemId = 202273, questId = 73054 },
        },
        -- Crest
        {
            -- Spiked
            { itemId = 197361, questId = 69562 },
            -- Spined
            { itemId = 197362, questId = 69563 },
            -- Short Spiked
            { itemId = 197364, questId = 69565 },
            -- Finned
            { itemId = 197365, questId = 69566 },
            -- Dual Horned
            { itemId = 197366, questId = 69567 },
        },
        -- Jaw
        {
            -- Thick Spined
            { itemId = 197355, questId = 69585 },
            -- Horned
            { itemId = 197385, questId = 69586 },
            -- Hairy
            { itemId = 197363, questId = 69564 },
            -- Spiked
            { itemId = 197386, questId = 69587 },
            -- Thin Spined
            { itemId = 197387, questId = 69588 },
            -- Finned
            { itemId = 197388, questId = 69589 },
            -- Plated
            { itemId = 202275, questId = 73059 },
        },
        -- Brow
        {
            -- Curved Spiked
            { itemId = 197358, questId = 69559 },
            -- Hairy
            { itemId = 197359, questId = 69560 },
            -- Spined
            { itemId = 197360, questId = 69561 },
            -- Plated
            { itemId = 202274, questId = 73055 },
        },
        -- Hair Color
        {
            -- Blue
            { itemId = 197368, questId = 69569 },
            -- Brown
            { itemId = 197369, questId = 69570 },
            -- Gray
            { itemId = 197367, questId = 69568 },
            -- Purple
            { itemId = 197372, questId = 69573 },
            -- Red
            { itemId = 197370, questId = 69571 },
            -- Green
            { itemId = 197371, questId = 69572, hidden = true },
        },
        -- Unknown sources / unimplemented
        {
            -- Hairy Back
            { itemId = 197356, questId = 69557, hidden = true },
            -- Horned Back
            { itemId = 197354, questId = 69555, hidden = true },
        },
    }
}
