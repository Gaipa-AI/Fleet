page 50009 "Fuel Requisitions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    Caption = 'Consumptions';
    CardPageId = "Fuel Requisition";
    SourceTable = "ADT Requisition Header";
    SourceTableView = WHERE("Document Type" = FILTER("Store Requisition"), "Request Type" = filter(Fuel));
    Permissions = tabledata "ADT Requisition Header" = rim,
                      tabledata "ADT Requisition Line" = rm,
                      tabledata "Email Related Attachment" = rim;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Request-By Name"; Rec."Request-By Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {

                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {

                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                }

                field("Requestor ID"; Rec."Requestor ID")
                {
                    Caption = 'Registered By';
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Co&mments")
            {
                ApplicationArea = Comments;
                Caption = 'Co&mments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Purch. Comment Sheet";
                RunPageLink = "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                ToolTip = 'View or add comments for the record.';
            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnOpenPage();
    begin
        Rec.SETRANGE("Document Type", Rec."Document Type"::"Store Requisition");
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Prepared by", USERID);
        Rec.FILTERGROUP(0);

        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        UserMgt: Codeunit "User Setup Management";
}