page 50081 ArchivedCashPurchaseLists
{
    ApplicationArea = All;
    Caption = 'Archived Cash Purchase Lists';
    PageType = List;
    SourceTable = "Archived Cash Purchase";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnDrillDown()var CMR: Record "Archived Cash Purchase";
                    begin // Check if the CMR document exists 
                        if CMR.Get(Rec."No.")then begin // Open the related CMR document page
                            PAGE.Run(PAGE::ArchiveCashPurchase, CMR);
                        end
                        else
                        begin
                            Message('Cash Purchase Document %1 does not exist.', Rec."No.");
                        end;
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Document Time"; Rec."Document Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Time field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Archived Date"; Rec."Archived Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Archived Date field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Approval Administrator" then
            Error('You do not have permission to view this page.');
    end;
}
