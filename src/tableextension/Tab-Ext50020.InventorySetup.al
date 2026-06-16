tableextension 50020 "InventorySetup_" extends "Inventory Setup"
{
    fields
    {
        field(50000; "Spare Transfer Template"; Code[20])
        {
            Caption = 'Spare Transfer Template';
            DataClassification = ToBeClassified;
        }
        field(50001; "Spare Transfer Batch"; Code[20])
        {
            Caption = 'Spare Transfer Batch';
            DataClassification = ToBeClassified;
        }
        field(50002; "Cash Purchase Nos"; Code[20])
        {
            Caption = 'Cash Purchase Nos';
            DataClassification = ToBeClassified;
        }
         field(50031;"Store Location";Code[20])
        {
            TableRelation = Location;
        }
       
    }
}
