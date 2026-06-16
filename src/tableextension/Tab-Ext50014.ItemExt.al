tableextension 50014 "ItemExt" extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Revenue Stream"; Code[20]) { }
        field(50001; "Requires Inspection"; Boolean) { }
        field(50002; "Item for Issue to Employees"; Boolean) { }
        field(50003; "Misc. Article Code"; Code[10])
        {
            TableRelation = "Misc. Article".Code;
        }
    }
}