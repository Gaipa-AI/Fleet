tableextension 50004 "User Setup FL" extends "User Setup"
{
    fields
    {
        field(50000; "SBU Head"; Boolean)
        {
            Editable = true;
        }
        field(50001; "Archive Document"; Boolean)
        {
        }
        field(50002; "EDIT PVL"; Boolean)
        {
        }
        field(50003; "Voucher Admin"; Boolean)
        {
        }
        field(50004; "Delegate Approval Requests1"; Boolean)
        {
            Description = 'Rights to delegate Medical Claims Requests and Leave requests Approvals.';
        }
        field(50005; "E-mail Address1"; Text[100])
        {
        }
        field(50006; "Change Amount on Approved Req."; Boolean)
        {
        }
        field(50007; Signature; BLOB)
        {
            SubType = Bitmap;
        }
        field(50008; "Export Payment File"; Boolean)
        {
            Description = 'Specifies whether a user has permissions to export payments to a file';
        }
        field(50009; "Edit Advance Status"; Boolean)
        {

        }
        field(50010; "Escalate to"; Code[50])
        {
            Caption = 'Escalate to';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            begin
                if Rec."Escalate to" <> '' then begin
                    if Rec."Escalate to" = Rec."User ID" then
                        Error('You cannot escalate to yourself.');
                end;
            end;
        }
        field(50011; "Budget Controller"; Boolean)
        {
            Description = 'Specifies users who can enter purchase requisition/payment requisition lines so as to perform budget checks';
        }
        field(50012; "Glue to Batch"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Requisition Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Edit Requisition Line"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Employee No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(50016; "Job Budget Controller"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Can Authorize Job"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Workshop Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Can Release Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Can Authorize Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Can Authorize Hire Request"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
         field(50022; "Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}