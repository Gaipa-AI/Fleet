tableextension 50012 "Item Journal Line FL" extends "Item Journal Line"
{
    fields
    {
        field(50000; "G/L Expense A/c"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50001; "Misc. Article Code"; Code[10])
        {
            TableRelation = "Misc. Article".Code;
        }
        field(50002; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(50003; "Store Req. No"; Code[20]) { }
        field(50004; "From Store Req"; Boolean) { }
        field(50005; "Store Req. Invt Charge Acc"; Code[20]) { }
        field(50006; "FA No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(50007; "Equipment No."; code[100])
        {
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            var
                Equipment: Record "Fixed Asset";
            begin
                IF "Equipment No." <> '' THEN BEGIN
                    IF Equipment.GET("Equipment No.") THEN BEGIN
                        Equipment.TestField("Equipment Type");
                        IF Equipment."Blocked" THEN
                            ERROR('Equipment: %1 is blocked.', Equipment."No.")
                        else begin
                            Rec.validate("Equipment Type", Equipment."Equipment Type");
                            Rec.Modify();
                        end;
                    END;
                END else begin
                    "Equipment Type" := '';
                    Rec.Modify();
                end;
            end;
        }
        field(50008; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
        }
        field(50009; "Responsible Employee"; Code[50])
        {
            TableRelation = Employee."No.";
        }
        field(50010; "Purchase Requisition No."; Code[20])
        {
        }
    }

    trigger OnBeforeModify()
    var
        UserSetup: Record "User Setup";
    begin
        if Rec."From Store Req" then begin
            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId);
            if UserSetup.FindFirst() then begin
                if not UserSetup."Requisition Admin" then
                    Error('You are not allowed to edit this Line.');
            end else begin
                Error('User is not setup');
            end;
        end;
    end;

    var
        myInt: Integer;
}