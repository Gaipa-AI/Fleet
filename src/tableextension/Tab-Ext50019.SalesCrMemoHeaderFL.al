tableextension 50019 "Sales Cr.Memo Header FL" extends "Sales Cr.Memo Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Equipment Hire No."; Code[30])
        {
            TableRelation = "Form Header"."No.";
        }
        field(50001; "Equipment Hire Invoice"; Boolean)
        {
            Editable = false;
        }
        field(50002; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
        }
        field(50003; "Hire Request No."; code[50])
        {
            TableRelation = "Form Header"."No.";
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}