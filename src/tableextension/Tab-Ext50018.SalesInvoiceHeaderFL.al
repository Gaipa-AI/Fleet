tableextension 50018 "Sales Invoice Header FL" extends "Sales Invoice Header"
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
            TableRelation = "Form Header"."No." where("Document Type" = FILTER("Internal Hire"|"External Hire"));
        }
        field(50004; "Hire Type"; Option)
        {
            
            OptionMembers = " ",INTERNAL,EXTERNAL;
            Editable = true;

         }
        field(50005; "Equipment No."; Code[20])
        {
           
            TableRelation = "Fixed Asset"."No." where("Equipment Status" = filter(Available));
            trigger OnValidate()
            var
                Equipment: Record "Fixed Asset";
                Employee: Record "Employee";
                begin
                    if Equipment.Get("Equipment No.") then begin
                    
                    "Equipment Name" := Equipment.Description;
                    end;
                    
                end;

        }
        field(50006; "Equipment Name"; Text[250])
        {
            Caption = 'Equipment Name';
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        // Add changes to keys here
        key(HireRequest;"Hire Request No.")
        {
            // Unique = true;

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}